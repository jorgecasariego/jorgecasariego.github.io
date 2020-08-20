---
title: "The Testing Pyramid"
layout: post
date: 2020-08-19 20:10
image: 
headerImage: false
tag:
- android
- testing
category: blog
author: jorgecasariego
description: Testing Strategy
---

When thinking about a testing strategy, there are three related testing aspects:

- **Scope**: how much of the code does the test touch? Tests can run on a single method, accross the entire application, or somewhere in between

- **Speed**: How fast does the test run? Test speeds can vary from milli-seconds to several minutes.

- **Fidelity**: How "real-world" is the test? For example, if part of the code you're testing needs to make a network request, does the test code actually make this network request, or does it fake the result? if the test actually talks with the network, this means it has higher fidelity. The trade-off is that the test could take longer to run, could result in errors if the network is down, or could be costly to use.

There are inherent trade-offs between these aspects. For example, speed and fidelity are a trade-off- the faster the test, generally, the less fidelity, and vice versa. One common way to divide automated tests is into these 3 categories:

- **Unit tests**: These are highly focused tests that run on a single class, usually a single method in that class. If a unit test fails, you can know exactly where in your code the issue is. They have low fidelity since in the real world, your app involves much more than the execution of one method or class. They are fast enough to run every time you change your code. They will most often be locally run tests (in the test source set). **Example**: Testing single methods in view models and repositories.

- **Integration tests**: These test the interaction of several classes to make sure they behave as expected when used together. One way to structure integration tests is to have them test a single feature, such as the ability to save a task. They test a larger scope of code than unit tests, but are still optimized to run fast, versus having full fidelity. They can be run either locally or as instrumentation tests, depending on the situation. **Example**: Testing all the functionality of a single fragment and view model pair.

- **End to End tests(E2e)**: Test a combination of features working together. They test large portions of the app, simulate real usage closely, and therefore are usually slow. They have the highest fidelity and tell you that your application actually works as a whole. By and large, these tests will be instrumented tests (in the androidTest source set) 
**Example**: Starting up the entire app and testing a few features together.


The suggested proportion of these tests is often represented by a pyramid, with the vast majority of tests being unit tests

![alt text](https://codelabs.developers.google.com/codelabs/advanced-android-kotlin-training-testing-test-doubles/img/ed5e6485d179c1b9.png 
"Figure 1. Testing Pyramid")

