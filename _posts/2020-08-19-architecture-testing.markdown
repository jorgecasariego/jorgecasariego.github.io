---
title: "Architecture and Testing"
layout: post
date: 2020-08-19 21:15
image: 
headerImage: false
tag:
- android
- testing
category: blog
author: jorgecasariego
description: Architecture Testing
---

Your ability to test your app at all the different levels of the testing pyramid is inherently tied to your app's architecture. For example, an extremely poorly-architected application might put all of its logic inside one method. You might be able to write an end to end test for this, since these tests tend to test large portions of the app, but what about writing unit or integration tests? With all of the code in one place, it's hard to test just the code related to a single unit or feature.

A better approach would be to break down the application logic into multiple methods and classes, allowing each piece to be tested in isolation. Architecture is a way to divide up and organize your code, which allows easier unit and integration testing.

The next image is a good example of a good architecture

![alt text](https://codelabs.developers.google.com/codelabs/advanced-android-kotlin-training-testing-test-doubles/img/284779b388dddec0.png 
"Figure 1. Architecture of TODO app")

