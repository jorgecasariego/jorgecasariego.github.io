---
title: "What is Smoke Testing?"
layout: post
date: 2020-09-01 17:18
image: 
headerImage: false
tag:
- testing
category: blog
author: jorgecasariego
description: Smoke Testing
---

**Smoke Testing**

moke Testing is a software testing process that determines whether the deployed software build is stable or not. Smoke testing is a confirmation for QA team to proceed with further software testing. It consists of a minimal set of tests run on each build to test software functionalities. Smoke testing is also known as "Build Verification Testing" or “Confidence Testing.”

In simple terms, we are verifying whether the important features are working and there are no showstoppers in the build that is under testing.

It is a mini and rapid regression test of major functionality. It is a simple test that shows the product is ready for testing. This helps determine if the build is flawed as to make any further testing a waste of time and resources.

![alt text](https://raw.githubusercontent.com/jorgecasariego/jorgecasariego.github.io/master/assets/images/posts/smoke_testing.png 
"Figure 1. Smoke Testing")

The smoke tests qualify the build for further formal testing. The main aim of smoke testing is to detect early major issues. Smoke tests are designed to demonstrate system stability and conformance to requirements.

A build includes all data files, libraries, reusable modules, engineered components that are required to implement one or more product functions.

## When do we do smoke testing

Smoke Testing is done whenever the new functionalities of software are developed and integrated with existing build that is deployed in QA/staging environment. It ensures that all critical functionalities are working correctly or not.

In this testing method, the development team deploys the build in QA. The subsets of test cases are taken, and then testers run test cases on the build. The QA team test the application against the critical functionalities. These series of test cases are designed to expose errors that are in build. If these tests are passed, QA team continues with Functional Testing.

Any failure indicates a need to handle the system back to the development team. Whenever there is a change in the build, we perform Smoke Testing to ensure the stability.

**Example:** New registration button is added in the login window and build is deployed with the new code. We perform smoke testing on a new build.

## Who will do Smoke Testing

After releasing the build to QA environment, Smoke Testing is performed by QA engineers/QA lead. Whenever there is a new build, QA team determines the major functionality in the application to perform smoke testing. QA team checks for showstoppers in the application that is under testing.

Testing done in a development environment on the code to ensure the correctness of the application before releasing build to QA, this is known as Sanity testing. It is usually narrow and deep testing. It is a process which verifies that the application under development meets its basic functional requirements.

Sanity testing determines the completion of the development phase and makes a decision whether to pass or not to pass software product for further testing phase.

## Why do we do smoke testing?

Smoke testing plays an important role in software development as it ensures the correctness of the system in initial stages. By this, we can save test effort. As a result, smoke tests bring the system to a good state. Once we complete smoke testing then only we start functional testing.

- All the show stoppers in the build will get identified by performing smoke testing.
- Smoke testing is done after the build is released to QA. With the help of smoke testing, most of the defects are identified at initial stages of software development.
- With smoke testing, we simplify the detection and correction of major defects.
- By smoke testing, QA team can find defects to the application functionality that may have surfaced by the new code.
- Smoke testing finds the major severity defects.

**Example 1:** Logging window: Able to move to next window with valid username and password on clicking submit button.

**Example 2:** User unable to sign out from the webpage.

## How to do Smoke Testing ?
Smoke Testing is usually done manually though there is a possibility of accomplishing the same through automation. It may vary from organization to organization.

**Manual Smoke testing**

In general, smoke testing is done manually. It approaches varies from one organization to other. Smoke testing is carried to ensure the navigation of critical paths is as expected and doesn't hamper the functionality. Once the build is released to QA, high priority functionality test cases are to be taken and are tested to find the critical defects in the system. If the test passes, we continue the functional testing. If the test fails, the build is rejected and sent back to the development team for correction. QA again starts smoke testing with a new build version. Smoke testing is performed on new build and will get integrated with old builds to maintain the correctness of the system. Before performing smoke testing, QA team should check for correct build versions.

**Smoke testing by Automation**

Automation Testing is used for Regression Testing. However, we can also use a set of automated test cases to run against Smoke Test. With the help of automation tests, developers can check build immediately, whenever there is a new build ready for deployment.

Instead of having repeated test manually whenever the new software build is deployed, recorded smoke test cases are executed against the build. It verifies whether the major functionalities still operates properly. If the test fails, then they can correct the build and redeploy the build immediately. By this, we can save time and ensure a quality build to the QA environment.

Using an automated tool, test engineer records all manual steps that are performed in the software build.

**Smoke testing cycle**

Below flow chart shows how Smoke Testing is executed. Once the build is deployed in QA and, smoke tests are passed we proceed for functional testing. If the smoke test fails, we exit testing until the issue in the build is fixed.

![alt text](https://github.com/jorgecasariego/jorgecasariego.github.io/blob/master/assets/images/posts/smoke_test-cycle.png?raw=true 
"Figure 2. Smoke Testing")

## Advantages of Smoke testing

Here are few advantages listed for Smoke Testing.

- Easy to perform testing
- Defects will be identified in early stages.
- Improves the quality of the system
- Reduces the risk
- Progress is easier to access.
- Saves test effort and time
- Easy to detect critical errors and correction of errors.
- It runs quickly
- Minimises integration risks

## What happens if we don't do Smoke testing

If we don't perform smoke testing in early stages, defects may be encountered in later stages where it can be cost effective. And the Defect found in later stages can be show stoppers where it may affect the release of deliverables.

## Summary:

In Software Engineering, Smoke testing should be performed on each and every build without fail as it helps to find defects in early stages. Smoke test activity is the final step before the software build enters the system stage. Smoke tests must be performed on each build that is turned to testing. This applies to new development and major and minor releases of the system.

Before performing smoke testing, QA team must ensure the correct build version of the application under test. It is a simple process which takes a minimum time to test the stability of the application.

Smoke tests can minimise test effort, and can improve the quality of the application. Smoke testing can be done either manually or by automation depending on the client and the organization.

**References:**
 - [Guru99](https://www.guru99.com/smoke-testing.html)
