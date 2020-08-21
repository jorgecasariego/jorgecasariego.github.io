---
title: "Espresso"
layout: post
date: 2020-08-21 17:30
image: 
headerImage: false
tag:
- android
- testing
category: blog
author: jorgecasariego
description: Espresso is used to write concise, beautiful, and reliable Android UI tests.
---

**androidx.test.espresso:espresso-core**

This core Espresso dependency is included by default when you make a new Android project. It contains the basic testing code for most views and actions on them.

# Turn off animations

Espresso tests run on a real device and thus are instrumentation tests by nature. One issue that arises is animations: If an animation lags and you try to test if a view is on screen, but it's still animating, Espresso can accidentally fail a test. This can make Espresso tests flaky.

For Espresso UI testing, it's best practice to turn animations off (also your test will run faster!):

1. On your testing device, go to Settings > Developer options.
2. Disable these three settings: Window animation scale, Transition animation scale, and Animator duration scale.


![alt text](https://codelabs.developers.google.com/codelabs/advanced-android-kotlin-training-testing-test-doubles/img/aed9ab560d3977b0.png 
"Figure 1. Turn off animation on device")

## Look at an Espresso test

Before you write an Espresso test, take a look at some Espresso code.

```
onView(withId(R.id.task_detail_complete_checkbox)).perform(click()).check(matches(isChecked()))
```

What this statement does is find the checkbox view with the id task_detail_complete_checkbox, clicks it, then asserts that it is checked.

The majority of Espresso statements are made up of four parts:

1. [Static Espresso method](https://developer.android.com/reference/androidx/test/espresso/Espresso.html#onView(org.hamcrest.Matcher%3Candroid.view.View%3E))

```
onView
```

onView is an example of a static Espresso method that starts an Espresso statement. onView is one of the most common ones, but there are other options, such as onData.

2.  [ViewMatcher](https://developer.android.com/reference/androidx/test/espresso/matcher/ViewMatchers.html)

```
withId(R.id.task_detail_title_text)
```

withId is an example of a ViewMatcher which gets a view by its ID. There are other view matchers which you can look up in the **[documentation](https://developer.android.com/reference/androidx/test/espresso/matcher/ViewMatchers.html)**.



With ViewModels or Repositories you can use constructor dependency injection to provide a dependency. Constructor dependency injection requires that you construct the class. Fragments and Activities are examples of classes that you don't construct and generally don't have access to the constructor of.

Since you don't construct the fragment, you can't use constructor dependency injection to swap the repository test double to the fragment. Instead, you can use [ServiceLocator](https://en.wikipedia.org/wiki/Service_locator_pattern) pattern. 

# ServiceLocator Pattern

The Service Locator pattern is an alternative to Dependency Injection. It involves creating a singleton class called the _"Service Locator"_, whose purpose is to provide dependencies, both for the regular and test code. In the regular app code (the main source set), all of these dependencies are the regular app dependencies. For the tests, you modify the Service Locator to provide test double versions of the dependencies.

**Not using Service Locator**



**Using a Service Locator**

![alt text](https://codelabs.developers.google.com/codelabs/advanced-android-kotlin-training-testing-test-doubles/img/8ea9e5c7be9e2974.png 
"Figure 1. Service Locator")
