---
title: "Test Double"
layout: post
date: 2020-08-20 10:30
image: 
headerImage: false
tag:
- android
- testing
category: blog
author: jorgecasariego
description: What are Android Test Doubles?
---

**Why testing the repository is hard?**

- You need to deal with thinking about creating and managing a database to do even the simplest tests for this repository. This brings up questions like "should this be a local or instrumented test?" and if you should be using AndroidX Test to get a simulated Android environment.

- Some parts of the code, such as networking code, can take a long time to run, or occasionally even fail, creating long running, flaky tests.

Flaky tests are tests that when run repeatedly on the same code, sometimes pass and sometimes fail. [Avoid them when possible.](https://testing.googleblog.com/2016/05/flaky-tests-at-google-and-how-we.html)

- Your tests could lose their ability to diagnose which code is at fault for a test failure. Your tests could start testing non-repository code, so, for example, your supposed "repository" unit tests could fail because of an issue in some of the dependant code, such as the database code.

# Test Doubles

The solution to this is that when you're testing the repository, don't use the real networking or database code, but to instead use a test double. A **test double** is a version of a class crafted specifically for testing. It is meant to replace the real version of a class in tests. It's similar to how a stunt double is an actor who specializes in stunts, and replaces the real actor for dangerous actions. These are sometimes all commonly referred to as “mocks”, but it's important to distinguish between the different types of test doubles since they all have different uses. The most common types of test doubles are **stubs, mocks, and fakes**.

Here are some types of test doubles:

## Fake
A fake doesn’t use a mocking framework: it’s a lightweight implementation of an API that behaves like the real implementation, but isn't suitable for production (e.g. an in-memory database). Fakes can be used when you can't use a real implementation in your test (e.g. if the real implementation is too slow or it talks over the network). You shouldn't need to write your own fakes often since fakes should usually be created and maintained by the person or team that owns the real implementation.

```
// Creating the fake is fast and easy.
AuthenticationService fakeAuthenticationService = new FakeAuthenticationService();
AccessManager accessManager = new AccessManager(fakeAuthenticationService);

// The user shouldn't have access since the authentication service doesn't
// know about the user.
assertFalse(accessManager.userHasAccess(USER_ID));

// The user should have access after it's added to the authentication service.
fakeAuthenticationService.addAuthenticatedUser(USER_ID);
assertTrue(accessManager.userHasAccess(USER_ID));
```

## Mock
A mock has expectations about the way it should be called, and a test should fail if it’s not called that way. Mocks are used to test interactions between objects, and are useful in cases where there are no other visible state changes or return results that you can verify (e.g. if your code reads from disk and you want to ensure that it doesn't do more than one disk read, you can use a mock to verify that the method that does the read is only called once).

```
// Pass in a mock that was created by a mocking framework.
AccessManager accessManager = new AccessManager(mockAuthenticationService);
accessManager.userHasAccess(USER_ID);

// The test should fail if accessManager.userHasAccess(USER_ID) didn't call
// mockAuthenticationService.isAuthenticated(USER_ID) or if it called it more than once.
verify(mockAuthenticationService).isAuthenticated(USER_ID);
```

## Stub
A test double that includes no logic and only returns what you program it to return. A StubTaskRepository could be programmed to return certain combinations of tasks from getTasks for example.

Stubs can be used when you need an object to return specific values in order to get your code under test into a certain state. While it's usually easy to write stubs by hand, using a mocking framework is often a convenient way to reduce boilerplate.

```
// Pass in a stub that was created by a mocking framework.
AccessManager accessManager = new AccessManager(stubAuthenticationService);

// The user shouldn't have access when the authentication service returns false.
when(stubAuthenticationService.isAuthenticated(USER_ID)).thenReturn(false);
assertFalse(accessManager.userHasAccess(USER_ID));

// The user should have access when the authentication service returns true. 
when(stubAuthenticationService.isAuthenticated(USER_ID)).thenReturn(true);
assertTrue(accessManager.userHasAccess(USER_ID));
```

## Dummy
A test double that is passed around but not used, such as if you just need to provide it as a parameter. If you had a NoOpTaskRepository, it would just implement the TaskRepository with no code in any of the methods.

## Spy
A test double which also keeps tracks of some additional information; for example, if you made a SpyTaskRepository, it might keep track of the number of times the addTask method was called.


*The term “test double” was coined by Gerard Meszaros in the book xUnit Test Patterns. You can find more information about test doubles in the book, or on the book’s website. You can also find a discussion about the different types of test doubles in this article by Martin Fowler.*

