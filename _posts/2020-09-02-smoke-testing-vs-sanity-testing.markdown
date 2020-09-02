---
title: "Sanity Testing Vs Smoke Testing"
layout: post
date: 2020-09-02 10:06
image: 
headerImage: false
tag:
- testing
category: blog
author: jorgecasariego
description: Sanity Testing Vs Smoke Testing
---

**Sanity Testing Vs Smoke Testing**

Smoke and Sanity testing are the most misunderstood topics in Software Testing. There is an enormous amount of literature on the subject, but most of them are confusing. The following article makes an attempt to address the confusion.

The key differences between Smoke and Sanity Testing can be learned with the help of the following diagram

![alt text](https://raw.githubusercontent.com/jorgecasariego/jorgecasariego.github.io/master/assets/images/posts/Sanity_Smoke_Testing.png 
"Figure 1. Sanity vs Smoke Testing")

To appreciate the above diagram lets first understand -

## What is a Software Build?

If you are developing a simple computer program which consists of only one source code file, you merely need to compile and link this one file, to produce an executable file. This process is very simple.
Usually, this is not the case. A typical Software Project consists of hundreds or even thousands of source code files. Creating an executable program from these source files is a complicated and time-consuming task.
You need to use "build" software to create an executable program and the process is called " Software Build"

## Smoke Testing

Smoke Testing is a software testing technique performed post software build to verify that the critical functionalities of software are working fine. It is executed before any detailed functional or regression tests are executed. The main purpose of smoke testing is to reject a software application with defects so that QA team does not waste time testing broken software application.

In Smoke Testing, the test cases chose to cover the most important functionality or component of the system. The objective is not to perform exhaustive testing, but to verify that the critical functionalities of the system are working fine.
For Example, a typical smoke test would be - Verify that the application launches successfully, Check that the GUI is responsive ... etc.

# KEY DIFFERENCE

* Smoke Testing has a goal to verify “stability” whereas Sanity Testing has a goal to verify “rationality”.
* Smoke Testing is done by both developers or testers whereas Sanity Testing is done by testers.
* Smoke Testing verifies the critical functionalities of the system whereas Sanity Testing verifies the new functionality like bug fixes.
* Smoke testing is a subset of acceptance testing whereas Sanity testing is a subset of Regression Testing.
* Smoke testing is documented or scripted whereas Sanity testing isn’t.
* Smoke testing verifies the entire system from end to end whereas Sanity Testing verifies only a particular component.

# What is Sanity Testing?

Sanity testing is a kind of Software Testing performed after receiving a software build, with minor changes in code, or functionality, to ascertain that the bugs have been fixed and no further issues are introduced due to these changes. The goal is to determine that the proposed functionality works roughly as expected. If sanity test fails, the build is rejected to save the time and costs involved in a more rigorous testing.

The objective is "not" to verify thoroughly the new functionality but to determine that the developer has applied some rationality (sanity) while producing the software. For instance, if your scientific calculator gives the result of 2 + 2 =5! Then, there is no point testing the advanced functionalities like sin 30 + cos 50.

## Points to note.


- Both sanity tests and smoke tests are ways to avoid wasting time and effort by quickly determining whether an application is too flawed to merit any rigorous testing. 
- Sanity Testing is also called tester acceptance testing.
- Smoke testing performed on a particular build is also known as a build verification test.
- One of the best industry practice is to conduct a Daily build and smoke test in software projects.
- Both smoke and sanity tests can be executed manually or using an automation tool.  When automated tools are used, the tests are often initiated by the same process that generates the build itself.
- As per the needs of testing, you may have to execute both Sanity and Smoke Tests in the software build. In such cases, you will first execute Smoke tests and then go ahead with Sanity Testing. In industry, test cases for Sanity Testing are commonly combined with that for smoke tests, to speed up test execution. Hence, it's a common that the terms are often confused and used interchangeably


**References:**
 - [Guru99](https://www.guru99.com/smoke-sanity-testing.html)
