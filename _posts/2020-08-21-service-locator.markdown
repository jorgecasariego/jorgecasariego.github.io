---
title: "Service Locator"
layout: post
date: 2020-08-21 16:30
image: 
headerImage: false
tag:
- android
- testing
category: blog
author: jorgecasariego
description: ServiceLocator
---

**When to use ServiceLocator?**

With ViewModels or Repositories you can use constructor dependency injection to provide a dependency. Constructor dependency injection requires that you construct the class. Fragments and Activities are examples of classes that you don't construct and generally don't have access to the constructor of.

Since you don't construct the fragment, you can't use constructor dependency injection to swap the repository test double to the fragment. Instead, you can use [ServiceLocator](https://en.wikipedia.org/wiki/Service_locator_pattern) pattern. 

# ServiceLocator Pattern

The Service Locator pattern is an alternative to Dependency Injection. It involves creating a singleton class called the _"Service Locator"_, whose purpose is to provide dependencies, both for the regular and test code. In the regular app code (the main source set), all of these dependencies are the regular app dependencies. For the tests, you modify the Service Locator to provide test double versions of the dependencies.

![alt text](https://codelabs.developers.google.com/codelabs/advanced-android-kotlin-training-testing-test-doubles/img/2637b6e8f3d14321.png 
"Figure 1. Service Locator")
