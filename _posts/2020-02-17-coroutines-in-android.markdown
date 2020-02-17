---
title: "Coroutines in your Android APP"
layout: post
date: 2020-02-17 17:43
image: 
headerImage: false
tag:
- android
- Coroutines
category: blog
author: jorgecasariego
description: A coroutine is a concurrency design pattern that you can use on Android to simplify code that executes asynchronously. Coroutines were added to Kotlin in version 1.3 and are based on established concepts from other languages.
---

# Android Coroutines
Kotlin [coroutines](https://kotlinlang.org/docs/reference/coroutines-overview.html) introduce a new style of concurrency that can be used on Android to simplify async code.

In the last few years, coroutines have grown in popularity and are now included in many popular programming languages such as [Javascript](https://javascript.info/async-await), [C#](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/concepts/async/), [Python](https://docs.python.org/3/library/asyncio-task.html), [Ruby](https://ruby-doc.org/core-2.1.1/Fiber.html), and [Go](https://tour.golang.org/concurrency/1) to name a few. Kotlin coroutines are based on established concepts that have been used to build large applications.

On Android, coroutines are a great solution to two problems:

1.  **Long running tasks**  are tasks that take too long to block the main thread.
2.  **Main-safety** allows you to ensure that any suspend function can be called from the main thread.

# Long running tasks

Fetching a webpage or interacting with an API both involve making a network request. Similarly, reading from a database or loading an image from disk involve reading a file. These sorts of things are called long running tasks — tasks that take far too long for your app to stop and wait for them

It can be hard to understand how fast a modern phone executes code compared to a network request. On a Pixel 2, a single CPU cycle takes just under 0.0000000004 seconds, a number that’s pretty hard to grasp in human terms. However, if you think of a network request as one blink of the eye, around 400 milliseconds (0.4 seconds), it’s easier to understand how fast the CPU operates. In one blink of an eye, or a somewhat slow network request, the CPU can execute over one billion cycles!

On Android, every app has a main thread that is in charge of handling UI (like drawing views) and coordinating user interactions. If there is too much work happening on this thread, the app appears to hang or slow down, leading to an undesirable user experience. Any long running task should be done without blocking the main thread, so your app doesn’t display what’s called “jank,” like frozen animations, or respond slowly to touch events.

In order to perform a network request off the main thread, a common pattern is callbacks. Callbacks provide a handle to a library that it can use to call back into your code at some future time. With callbacks, fetching developer.android.com might look like this:

<script src="https://gist.github.com/jorgecasariego/6d0de282fe0ce892550b841f23650ae5.js"></script>

Even though `get` is called from the main thread, it will use another thread to perform the network request. Then, once the result is available from the network, the callback will be called on the main thread. This is a great way to handle long running tasks, and libraries like [Retrofit](https://square.github.io/retrofit/) can help you make network requests without blocking the main thread.

# Using coroutines for long running tasks

Coroutines are a way to simplify the code used to manage long running tasks like  `fetchDocs`. To explore how coroutines make the code for long running tasks simpler, let’s rewrite the callback example above to use coroutines.

<script src="https://gist.github.com/jorgecasariego/0d41272f9de40f4b69446707a22a6056.js"></script>

Doesn’t this code block the main thread? How does it return a result from `get` without waiting for the network request and blocking? It turns out coroutines provide a way for Kotlin to execute this code and never block the main thread.

Coroutines build upon regular functions by adding two new operations. In addition to  **invoke**  (or call) and  **return**, coroutines add  **suspend**  and  **resume**.

-   **suspend**  — pause the execution of the current coroutine, saving all local variables
-   **resume**  — continue a suspended coroutine from the place it was paused

This functionality is added by Kotlin by the suspend keyword on the function. You can only call suspend functions from other suspend functions, or by using a coroutine builder like  `[launch](https://kotlin.github.io/kotlinx.coroutines/kotlinx-coroutines-core/kotlinx.coroutines/launch.html)`  to start a new coroutine.

In the example above, `get` will **suspend** the coroutine before it starts the network request. The function `get` will still be responsible for running the network request off the main thread. Then, when the network request completes, instead of calling a callback to notify the main thread, it can simply **resume** the coroutine it suspended.

![](https://miro.medium.com/max/888/1*U24_ZyMJKI_c2qMspCXxZw.gif)

Animation showing how Kotlin implements suspend and resume to replace callbacks.

Looking at how `fetchDocs` executes, you can see how **suspend** works. Whenever a coroutine is suspended, the current stack frame (the place that Kotlin uses to keep track of which function is running and its variables) is copied and saved for later. When it **resumes**, the stack frame is copied back from where it was saved and starts running again. In the middle of the animation — when all of the coroutines on the main thread are suspended, the main thread is free to update the screen and handle user events. Together, suspend and resume replace callbacks.

Even though we wrote straightforward sequential code that looks exactly like a blocking network request, coroutines will run our code exactly how we want and avoid blocking the main thread!

# Main-safety with coroutines

In Kotlin coroutines, well written suspend functions are always safe to call from the main thread. No matter what they do, they should always allow any thread to call them.

But, there’s a lot of things we do in our Android apps that are too slow to happen on the main thread. Network requests, parsing JSON, reading or writing from the database, or even just iterating over large lists. Any of these have the potential to run slowly enough to cause user visible “jank” and should run off the main thread.

Using `suspend` doesn’t tell Kotlin to run a function on a background thread. It’s worth saying clearly and often that coroutines will run on the main thread. In fact, it’s a really good idea to use [Dispatchers.Main.immediate](https://kotlin.github.io/kotlinx.coroutines/kotlinx-coroutines-core/kotlinx.coroutines/-main-coroutine-dispatcher/immediate.html) when launching a coroutine in response to a UI event — that way, if you don’t end up doing a long running task that requires main-safety, the result can be available in the very next frame for the user.

> Using `suspend` doesn’t tell Kotlin to run a function on a background
> thread.

To make a function that does work that’s too slow for the main thread main-safe, you can tell Kotlin coroutines to perform work on either the `Default` or `IO` dispatcher. In Kotlin, all coroutines must run in a dispatcher — even when they’re running on the main thread. Coroutines can **suspend** themselves, and the dispatcher is the thing that knows how to **resume** them.

To specify where the coroutines should run, Kotlin provides three  [Dispatchers](https://kotlin.github.io/kotlinx.coroutines/kotlinx-coroutines-core/kotlinx.coroutines/-coroutine-dispatcher/)  you can use for thread dispatch.

**+-----------------------------------+  
|         Dispatchers.**[**Main**](https://kotlin.github.io/kotlinx.coroutines/kotlinx-coroutines-core/kotlinx.coroutines/-dispatchers/-main.html) **|  
+-----------------------------------+**  
| Main thread on Android, interact  |  
| with the UI and perform light     |  
| work                              |  
+-----------------------------------+  
| - Calling suspend functions       |  
| - Call UI functions               |  
| - Updating LiveData               |  
+-----------------------------------+  
  
**+-----------------------------------+  
|          Dispatchers.**[**IO**](https://kotlin.github.io/kotlinx.coroutines/kotlinx-coroutines-core/kotlinx.coroutines/-dispatchers/-i-o.html) **|  
+-----------------------------------+**  
| Optimized for disk and network IO |  
| off the main thread               |  
+-----------------------------------+  
| - Database*                       |  
| - Reading/writing files           |  
| - Networking**                    |  
+-----------------------------------+  
**  
+-----------------------------------+  
|        Dispatchers.**[**Default**](https://kotlin.github.io/kotlinx.coroutines/kotlinx-coroutines-core/kotlinx.coroutines/-dispatchers/-default.html) **|  
+-----------------------------------+**  
| Optimized for CPU intensive work  |  
| off the main thread               |  
+-----------------------------------+  
| - Sorting a list                  |  
| - Parsing JSON                    |  
| - DiffUtils                       |  
+-----------------------------------+

_*_ [_Room_](https://developer.android.com/topic/libraries/architecture/room) _will provide main-safety automatically if you use_ [_suspend functions_](https://medium.com/androiddevelopers/room-coroutines-422b786dc4c5)_,_ [_RxJava_](https://medium.com/androiddevelopers/room-rxjava-acb0cd4f3757)_, or_ [_LiveData_](https://developer.android.com/topic/libraries/architecture/livedata#use_livedata_with_room)_._

_** Networking libraries such as_ [_Retrofit_](https://square.github.io/retrofit/) _and_ [_Volley_](https://developer.android.com/training/volley) _manage their own threads and do not require explicit main-safety in your code when used with Kotlin coroutines._

To continue with the example above, let’s use the dispatchers to define the `get` function. Inside the body of `get` you call `withContext(Dispatchers.IO)` to create a block that will run on the `IO` dispatcher. Any code you put inside that block will _always_ execute on the `IO` dispatcher. Since `withContext` is itself a suspend function, it will work using coroutines to provide main safety.

<script src="https://gist.github.com/jorgecasariego/cbf0b94e14e70b312742120319cebc20.js"></script>

With coroutines you can do thread dispatch with fine-grained control. Because  `withContext`  lets you control what thread any line of code executes on without introducing a callback to return the result, you can apply it to very small functions like reading from your database or performing a network request. So a good practice is to use  `withContext`  to make sure every function is safe to be called on any  `Dispatcher`  including  `Main`  — that way the caller never has to think about what thread will be needed to execute the function.

In this example,  `fetchDocs`  is executing on the main thread, but can safely call  `get`  which performs a network request in the background. Because coroutines support  **suspend**  and  **resume**, the coroutine on the main thread will be resumed with the result as soon as the  `withContext`  block is complete.

It’s a really good idea to make every suspend function main-safe. If it does anything that touches the disk, network, or even just uses too much CPU, use `withContext` to make it safe to call from the main thread. This is the pattern that coroutines based libraries like Retrofit and Room follow. If you follow this style throughout your codebase your code will be much simpler and avoid mixing threading concerns with application logic. When followed consistently, coroutines are free to launch on the main thread and make network or database requests with simple code while guaranteeing users won’t see “jank.”

# Performance of withContext

`withContext`  is as fast as callbacks or RxJava for providing main safety. It’s even possible to optimize  `withContext`  calls beyond what’s possible with callbacks in some situations. If a function will make 10 calls to a database, you can tell Kotlin to switch once in an outer  `withContext`  around all 10 calls. Then, even though the database library will call  `withContext`  repeatedly, it will stay on the same dispatcher and follow a fast-path. In addition, switching between  `Dispatchers.Default`  and  `Dispatchers.IO`  is optimized to avoid thread switches whenever possible.

**References:**

- [https://developer.android.com/kotlin/coroutines](https://developer.android.com/kotlin/coroutines)
- [https://medium.com/androiddevelopers/coroutines-on-android-part-i-getting-the-background-3e0e54d20bb](https://medium.com/androiddevelopers/coroutines-on-android-part-i-getting-the-background-3e0e54d20bb)



