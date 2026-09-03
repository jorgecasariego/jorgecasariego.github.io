#!/usr/bin/env ruby
# Fetches the Mobile Coding Academy Substack RSS feed and writes the 3 most
# recent posts to _data/latest_writing.yml, so the homepage can render them
# as plain static Liquid with no client-side fetch.
#
# On any failure (network error, bad status, malformed feed) this script
# logs a warning and exits 0 WITHOUT touching the data file, so the last
# known-good list keeps being served. Safe to run locally or in CI.

require "net/http"
require "rexml/document"
require "yaml"
require "time"
require "fileutils"

FEED_URL = "https://mobilecodingacademy.substack.com/feed"
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
  items = REXML::XPath.match(doc, "//item").first(MAX_ITEMS)

  entries = items.map do |item|
    title = item.elements["title"]&.text&.strip
    link = item.elements["link"]&.text&.strip
    pub_date = item.elements["pubDate"]&.text&.strip

    next if title.nil? || title.empty? || link.nil? || link.empty?

    entry = { "title" => title, "url" => link }
    entry["date"] = Time.parse(pub_date).strftime("%Y-%m-%d") if pub_date
    entry
  end.compact

  raise "no valid items found in feed" if entries.empty?

  entries
end

begin
  entries = extract_entries(fetch(FEED_URL))
  FileUtils.mkdir_p(File.dirname(DATA_FILE))
  File.write(DATA_FILE, entries.to_yaml)
  puts "[sync_latest_writing] wrote #{entries.size} item(s) to #{DATA_FILE}"
rescue StandardError => e
  warn "[sync_latest_writing] skipping update (#{e.class}: #{e.message})"
  exit 0
end
