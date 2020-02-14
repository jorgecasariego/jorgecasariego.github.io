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

Create and test code iteratively
When developing a feature iteratively, you start by either writing a new test or by adding cases and assertions to an 
existing unit test. The test fails at first because the feature isn't implemented yet.

It's important to consider the units of responsibility that emerge as you design the new feature. For each unit, you 
write a corresponding unit test. Your unit tests should nearly exhaust all possible interactions with the unit, 
including standard interactions, invalid inputs, and cases where resources aren't available. 

![alt text](https://developer.android.com/images/training/testing/testing-workflow.png 
"Figure 1. The two cycles associated with iterative, test-driven development")

The full workflow, as shown in Figure 1, contains a series of nested, iterative cycles where a long, slow, UI-driven 
cycle tests the integration of code units. You test the units themselves using shorter, faster development cycles. 
This set of cycles continues until your app satisfies every use case.

### View your app as a series of modules

To make your code easier to test, develop your code in terms of modules, where each module represents a specific task 
that users complete within your app. This perspective contrasts the stack-based view of an app that typically contains 
layers representing the UI, business logic, and data.

For example, a "task list" app might have modules for creating tasks, viewing statistics about completed tasks, and 
taking photographs to associate with a particular task. Such a modular architecture also helps you keep unrelated 
classes decoupled and provides a natural structure for assigning ownership within your development team.

It's important to set well-defined boundaries around each module, and to create new modules as your app grows in 
scale and complexity. Each module should have only one area of focus, and the APIs that allow for inter-module 
communication should be consistent. To make it easier and quicker to test these inter-module interactions, consider 
creating fake implementations of your modules. In your tests, the real implementation of one module can call the fake 
implementation of the other module.

## Configure your test environment

### Organize test directories based on execution environment

A typical project in Android Studio contains two directories in which you place tests. Organize your tests as follows:
    
* The **androidTest** directory should contain the tests that run on real or virtual devices. Such tests include 
integration tests, end-to-end tests, and other tests where the JVM alone cannot validate your app's functionality.
* The **test** directory should contain the tests that run on your local machine, such as unit tests.

### Consider tradeoffs of running tests on different types of devices

When running your tests on a device, you can choose among the following types:

* Real device
* Virtual device (such as the emulator in Android Studio)
* Simulated device (such as Robolectric)

## Write your tests

After you've configured your testing environment, it's time to write tests that evaluate your app's functionality.

### Levels of the Testing Pyramid

<div class="side-by-side">
    <div class="toleft">
        <img class="image" src="https://developer.android.com/images/training/testing/pyramid.png" alt="Alt Text">
        <figcaption class="caption">Figure 2. The Testing Pyramid, showing the three categories of tests that you should include in your app's test suite</figcaption>
    </div>
</div>

The Testing Pyramid, shown in Figure 2, illustrates how your app should include the three categories of tests: small, medium, and large:
 * **Small tests** are unit tests that validate your app's behavior one class at a time.
 * **Medium tests** are integration tests that validate either interactions between levels of the stack within a module, or interactions between related modules.
 * **Large tests** are end-to-end tests that validate user journeys spanning multiple modules of your app.</p>

As you work up the pyramid, from small tests to large tests, each test increases in fidelity but also increases in 
execution time and effort to maintain and debug. Therefore, you should write more unit tests than integration tests, 
and more integration tests than end-to-end tests. Although the proportion of tests for each category can vary based on
your app's use cases, we generally recommend the following split among the categories: **70 percent small, 20
percent medium, and 10 percent large**.
  
---

## Build-effective-unit-tests



---

## Automate-user-interface-tests


---

## Test-app-component-integrations


---

## Test UI performance


---


## Espresso


---

## UI-Automator


---

## JUnit4-rules-with-AndroidX-Test


---

## AndroidJUnitRunner


---

## Additional-Resources-for-Testing


---
