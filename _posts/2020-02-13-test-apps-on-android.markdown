---
title: "Test apps on Android "
layout: post
date: 2020-02-13 18:03
image: 
headerImage: false
tag:
- android
- testing
category: blog
author: jorgecasariego
description: All about testing on Android
---

## Description

By running tests against your app consistently, you can verify your app's correctness, functional behavior, and usability 
before you release it publicly.

Testing also provides you with the following advantages:

- **Rapid feedback** on failures.
- **Early failure detection** in the development cycle.
- **Safer code refactoring**, letting you optimize code without worrying about regressions.
- **Stable development velocity**, helping you minimize technical debt.


<iframe width="560" height="310" src="https://www.youtube.com/watch?v=VJi2vmaQe6w" frameborder="0" allowfullscreen></iframe>


#### Especial Elements
- [Fundamentals-of-Testing](#fundamentals-of-testing)
- [Build-effective-unit-tests](#build-effective-unit-tests)
- [Automate-user-interface-tests](#automate-user-interface-tests)
- [Test-app-component-integrations](#test-app-component-integrations)
- [Test-UI-performance](#test-ui-performance)
- [Espresso](#espresso)
- [UI-Automator](#ui-automator)
- [JUnit4-rules-with-AndroidX-Test](#junit4-rules-with-androidx-test)
- [AndroidJUnitRunner](#androidjunitrunner)
- [Additional-Resources-for-Testing](#additional-resources-for-testing)

#### Samples

---

## Fundamentals-of-Testing

Users interact with your app on a variety of levels, from pressing a button to downloading information onto their device.
Accordingly, you should test a variety of use cases and interactions as you iteratively develop your app.

#### Organize your code for testing
As your app expands, you might find it necessary to fetch data from a server, interact with the device's sensors, access 
local storage, or render complex user interfaces. The versatility of your app demands a comprehensive testing strategy.

---

## Build-effective-unit-tests

Like the [Medium](https://medium.com/) component.

**Image** on the left and **Text** on the right:

{% highlight html %}
<div class="side-by-side">
    <div class="toleft">
        <img class="image" src="{{ site.url }}/{{ site.picture }}" alt="Alt Text">
        <figcaption class="caption">Photo by John Doe</figcaption>
    </div>

    <div class="toright">
        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
    </div>
</div>
{% endhighlight %}

<div class="side-by-side">
    <div class="toleft">
        <img class="image" src="{{ site.url }}/{{ site.picture }}" alt="Alt Text">
        <figcaption class="caption">Photo by John Doe</figcaption>
    </div>

    <div class="toright">
        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
    </div>
</div>

**Text** on the left and **Image** on the right:

{% highlight html %}
<div class="side-by-side">
    <div class="toleft">
        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
    </div>

    <div class="toright">
        <img class="image" src="{{ site.url }}/{{ site.picture }}" alt="Alt Text">
        <figcaption class="caption">Photo by John Doe</figcaption>
    </div>
</div>
{% endhighlight %}

<div class="side-by-side">
    <div class="toleft">
        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
    </div>

    <div class="toright">
        <img class="image" src="{{ site.url }}/{{ site.picture }}" alt="Alt Text">
        <figcaption class="caption">Photo by John Doe</figcaption>
    </div>
</div>

---

## Automate-user-interface-tests

You can give evidence to a post. Just add the tag to the markdown file.

{% highlight raw %}
star: true
{% endhighlight %}

---

## Test-app-component-integrations

You can add a especial *hr* to your text.

{% highlight html %}
<div class="breaker"></div>
{% endhighlight %}

<div class="breaker"></div>

---

## Test UI performance

You can add an especial hidden content that appears on hover.

{% highlight html %}
<div class="spoiler"><p>your content</p></div>
{% endhighlight %}

<div class="spoiler"><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p></div>

---


## Espresso

You can add an especial hidden content that appears on hover.

---

## UI-Automator

You can add an especial hidden content that appears on hover.

---

## JUnit4-rules-with-AndroidX-Test

You can add an especial hidden content that appears on hover.

---

## AndroidJUnitRunner

You can add an especial hidden content that appears on hover.

---

## Additional-Resources-for-Testing

You can add an especial hidden content that appears on hover.

---
