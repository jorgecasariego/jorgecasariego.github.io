#!/usr/bin/env ruby
# Fetches Jorge's Substack RSS feeds (Mobile Coding Academy + personal) and
# writes the 3 most recent posts across both, newest first, to
# _data/latest_writing.yml, so the homepage can render them as plain static
# Liquid with no client-side fetch.
#
# Each feed is fetched independently: if one feed is unreachable or malformed,
# it's skipped with a warning and the other feed's posts are still used. The
# data file is only overwritten if at least one valid entry was found across
# all feeds; any other failure leaves the last known-good list untouched.
# Safe to run locally or in CI.

require "net/http"
require "rexml/document"
require "yaml"
require "time"
require "fileutils"

FEED_URLS = [
  "https://mobilecodingacademy.substack.com/feed",
  "https://jorgecasariego.substack.com/feed"
]
MAX_ITEMS = 3
DATA_FILE = File.expand_path("../_data/latest_writing.yml", __dir__)

def fetch(url)
  uri = URI(url)
  response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == "https",
                              open_timeout: 10, read_timeout: 10) do |http|
    http.get(uri)
  end

  raise "unexpected response code #{response.code}" unless response.code == "200"
  raise "empty response body" if response.body.nil? || response.body.strip.empty?

  response.body
end

def extract_entries(xml_body)
  doc = REXML::Document.new(xml_body)
  items = REXML::XPath.match(doc, "//item")

  entries = items.map do |item|
    title = item.elements["title"]&.text&.strip
    link = item.elements["link"]&.text&.strip
    pub_date = item.elements["pubDate"]&.text&.strip
    image = item.elements["enclosure"]&.attributes&.[]("url")

    next if title.nil? || title.empty? || link.nil? || link.empty? || pub_date.nil?

    { "title" => title, "url" => link, "image" => image, "_time" => Time.parse(pub_date) }
  end.compact

  raise "no valid items found in feed" if entries.empty?

  entries
end

all_entries = FEED_URLS.flat_map do |url|
  extract_entries(fetch(url))
rescue StandardError => e
  warn "[sync_latest_writing] skipping feed #{url} (#{e.class}: #{e.message})"
  []
end

if all_entries.empty?
  warn "[sync_latest_writing] no valid entries found across any feed, leaving data file untouched"
  exit 0
end

entries = all_entries
  .sort_by { |e| -e["_time"].to_i }
  .first(MAX_ITEMS)
  .map { |e| { "title" => e["title"], "url" => e["url"], "date" => e["_time"].strftime("%Y-%m-%d"), "image" => e["image"] }.compact }

FileUtils.mkdir_p(File.dirname(DATA_FILE))
File.write(DATA_FILE, entries.to_yaml)
puts "[sync_latest_writing] wrote #{entries.size} item(s) to #{DATA_FILE}"
