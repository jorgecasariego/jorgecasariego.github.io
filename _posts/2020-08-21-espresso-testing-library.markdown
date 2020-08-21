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

2. [ViewMatcher](https://developer.android.com/reference/androidx/test/espresso/matcher/ViewMatchers.html)

```
withId(R.id.task_detail_title_text)
```

withId is an example of a ViewMatcher which gets a view by its ID. There are other view matchers which you can look up in the **[documentation](https://developer.android.com/reference/androidx/test/espresso/matcher/ViewMatchers.html)**.

3. [ViewAction](https://developer.android.com/reference/androidx/test/espresso/ViewAction.html)

```
perform(click())
```

The perform method which takes a ViewAction. A ViewAction is something that can be done to the view, for example here, it's clicking the view.


4. [ViewAssertion](https://developer.android.com/reference/androidx/test/espresso/assertion/ViewAssertions#matches)

```
check(matches(isChecked()))
```

check which takes a ViewAssertion. ViewAssertions check or asserts something about the view. The most common ViewAssertion you'll use is the matches assertion. To finish the assertion, use another ViewMatcher, in this case isChecked.


![alt text](https://codelabs.developers.google.com/codelabs/advanced-android-kotlin-training-testing-test-doubles/img/fa5526f1e3b48281.png 
"Figure 1. Service Locator")
