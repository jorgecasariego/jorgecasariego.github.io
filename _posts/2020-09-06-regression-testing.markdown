---
title: "Regression Testing"
layout: post
date: 2020-09-06 21:52
image: 
headerImage: false
tag:
- testing
category: blog
author: jorgecasariego
description: What is Regression Testing?
---

## What is Regression Testing?

REGRESSION TESTING is defined as a type of software testing to confirm that a recent program or code change has not adversely affected existing features.

Regression Testing is nothing but a full or partial selection of already executed test cases which are re-executed to ensure existing functionalities work fine.

This testing is done to make sure that new code changes should not have side effects on the existing functionalities. It ensures that the old code still works once the latest code changes are done.

## Need of Regression Testing

The Need of Regression Testing mainly arises whenever there is requirement to change the code and we need to test whether the modified code affects the other part of software application or not. Moreover, regression testing is needed, when a new feature is added to the software application and for defect fixing as well as performance issue fixing.

## How to do Regression Testing

In order to do Regression Testing process, we need to first debug the code to identify the bugs. Once the bugs are identified, required changes are made to fix it, then the regression testing is done by selecting relevant test cases from the test suite that covers both modified and affected parts of the code.

Software maintenance is an activity which includes enhancements, error corrections, optimization and deletion of existing features. These modifications may cause the system to work incorrectly. Therefore, Regression Testing becomes necessary. Regression Testing can be carried out using the following techniques:

![alt text](https://raw.githubusercontent.com/jorgecasariego/jorgecasariego.github.io/master/assets/images/posts/regressiontestingtypes.png 
"Figure 1. Sanity vs Smoke Testing")

## Retest All

This is one of the methods for Regression Testing in which all the tests in the existing test bucket or suite should be re-executed. This is very expensive as it requires huge time and resources.

## Regression Test Selection

**Regression Test Selection** is a technique in which some selected test cases from test suite are executed to test whether the modified code affects the software application or not. Test cases are categorized into two parts, reusable test cases which can be used in further regression cycles and obsolete test cases which can not be used in succeeding cycles.

## Prioritization of Test Cases

Prioritize the test cases depending on business impact, critical & frequently used functionalities. Selection of test cases based on priority will greatly reduce the regression test suite.

## Selecting test cases for regression testing
It was found from industry data that a good number of the defects reported by customers were due to last minute bug fixes creating side effects and hence selecting the Test Case for regression testing is an art and not that easy.  Effective Regression Tests can be done by selecting the following test cases:

- Test cases which have frequent defects
- Functionalities which are more visible to the users
- Test cases which verify core features of the product
- Test cases of Functionalities which has undergone more and recent changes
- All Integration Test Cases
- All Complex Test Cases
- Boundary value test cases
- A sample of Successful test cases
- A sample of Failure test cases

## Regression Testing Tools

If your software undergoes frequent changes, regression testing costs will escalate.

In such cases, Manual execution of test cases increases test execution time as well as costs.

Automation of regression test cases is the smart choice in such cases.  

The extent of automation depends on the number of test cases that remain re-usable for successive regression cycles. 

# Regression Testing and Configuration Management

Configuration Management during Regression Testing becomes imperative in Agile Environments where a code is being continuously modified. To ensure effective regression tests, observe the following :

Code being regression tested should be under a configuration management tool
No changes must be allowed to code, during the regression test phase.  Regression test code must be kept immune to developer changes.
The database used for regression testing must be isolated. No database changes must be allowed

## Difference between Re-Testing and Regression Testing:
Retesting means testing the functionality or bug again to ensure the code is fixed. If it is not fixed, Defect needs to be re-opened. If fixed, Defect is closed.

Regression testing means testing your software application when it undergoes a code change to ensure that the new code has not affected other parts of the software.

## Following are the major testing problems for doing regression testing:

With successive regression runs, test suites become fairly large.  Due to time and budget constraints, the entire regression test suite cannot be executed
Minimizing the test suite while achieving maximum Test coverage remains a challenge
Determination of frequency of Regression Tests, i.e., after every modification or every build update or after a bunch of bug fixes, is a challenge.

**References:**
 - [Guru99](https://www.guru99.com/regression-testing.html)
