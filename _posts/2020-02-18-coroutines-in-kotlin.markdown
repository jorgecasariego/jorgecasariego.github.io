---
title: "Kotlin Coroutines"
layout: post
date: 2020-02-18 22:06
image: 
headerImage: false
tag:
- Coroutines
- Kotlin
category: blog
author: jorgecasariego
description: Asynchronous or non-blocking programming is the new reality. Whether we're creating server-side, desktop or mobile applications, it's important that we provide an experience that is not only fluid from the user's perspective, but scalable when needed. There are many approaches to this problem, and in Kotlin it take a very flexible one by providing Coroutine support at the language level and delegating most of the functionality to libraries.
---

# Kotlin Coroutines

Kotlin v1.3 was released bringing coroutines for asynchronous programming. This article is a quick introduction to the core features of  `kotlinx.coroutines`.

Let’s say the objective is to say hello asynchronously. Lets start with the following very classic code:

<script src="https://gist.github.com/jorgecasariego/deb0a2e3248f00d591680ab3b62c1fed.js"></script>

```
Start
Done
Hello

```

What happened within the 3 seconds when the created  `Thread`  was sleeping? The answer: nothing! The thread was occupying memory without being used! This is when coroutines the light-weight threads kick in!

## First Coroutine

The following is a basic way to migrate the previous example to use coroutines:

<script src="https://gist.github.com/jorgecasariego/9d5f9a1abd2e580e210d21d87b4563ff.js"></script>

```
Start
Done
Hello

```

The coroutine is launched with  `launch`  _coroutine builder_  in a context of a  `CoroutineScope`  (in this case  `GlobalScope`). But what are _suspending functions_ ?  _coroutine builders_  ?  _coroutine contexts_  ?  _coroutine scopes_?

## Suspending functions

Suspending functions are at the center of everything coroutines. A suspending function is simply a function that can be paused and resumed at a later time. They can execute a long running operation and wait for it to complete without blocking.

The syntax of a suspending function is similar to that of a regular function except for the addition of the  `suspend` keyword. It can take a parameter and have a return type. However, suspending functions can only be invoked by another suspending function or within a coroutine.

<script src="https://gist.github.com/jorgecasariego/d0d41767c038f5cbb96eb4b220ecc5c0.js"></script>

Under the hood, suspend functions are converted by the compiler to another function without the suspend keyword, that takes an addition parameter of type `Continuation<T>` . The function above for example, will be converted by the compiler to this:

<script src="https://gist.github.com/jorgecasariego/45a2f348893e1f62d5ab3d2516585f96.js"></script>

`Continuation<T>` is an interface that contains two functions that are invoked to resume the coroutine with a return value or with an exception if an error had occurred while the function was suspended.

<script src="https://gist.github.com/jorgecasariego/d3de6b79012e88ac63967ef2e61499ee.js"></script>

## Coroutine Builders

Coroutine builders are simple functions to create a new coroutine; the following are the main ones:

-   `launch`: used for starting a computation that isn’t expected to return a specific result.  `launch`  _starts_  a coroutine and  _returns_  a  `Job`, which represents the coroutine. It is possible to wait until it completes by calling  `Job.join()`.
-   `async`: like  `launch`  it starts a new coroutine, but returns a  `Deferred`* object instead: it stores a computation, but it  _defers_  the final result; it  _promises_  the result sometime in the_future_.
-   `runBlocking`: used as a bridge between blocking and non-blocking worlds. It works as an adaptor starting the top-level main coroutine and is intended primarily to be used in  _main functions_  and in  _tests_.
-   `withContext`: calls the given code with the specified coroutine context, suspends until it completes, and returns the result. An alternative (but more verbose) way to achieve the same thing would be:  `launch(context) { … }.join()`.

_*_  `Deffered`  _is a generic type which extends_  `Job`.

### Building Coroutines

Lets use coroutines builders to improve the previous example by introducing  `runBlocking`:

<script src="https://gist.github.com/jorgecasariego/451f7fbf84160b3708496b5dfb44a742.js"></script>

It is possible to do better ? Yes ! By moving the `runBlocking` to wrap the execution of the main function:

<script src="https://gist.github.com/jorgecasariego/bc65994adf7e25acec2f357ed05a4892.js"></script>

But wait a minute, the initial goal of having `delay(2000L)` was to wait for the coroutine to finish ! Let’s explicitly wait for it then:

<script src="https://gist.github.com/jorgecasariego/88db10d884b85e632ba6bfc27353558f.js"></script>

## Structured concurrency

In the previous example,  `GlobalScope.launch`  has been used to create a top-level “independent” coroutine. Why “top-level” ? Because  `GlobalScope`  is used to launch coroutines which are operating on  _the whole application lifetime_. “_Structured concurrency_” is the mechanism providing the structure of coroutines which gives the following benefits:

-   The scope is generally responsible for children coroutines, and their lifetime is attached to the lifetime of the scope.
-   The scope can automatically cancel children coroutines in case of the operation canceling or revoke.
-   The scope automatically waits for completion of all the children coroutines.

![Job lifecycle](https://mouaad.aallam.com/assets/images/blog/job_lifecycle.svg)

Coroutine (Job) Lifecycle

Let’s apply this to our example:

<script src="https://gist.github.com/jorgecasariego/6428136a73f30409ab4c1b962eb09e35.js"></script>

### Using the outer scope’s context

At this point, an option may be to move the inner coroutine to a function:

<script src="https://gist.github.com/jorgecasariego/c50806ea54bbff404a65c249d7258560.js"></script>

This works, but there is a more elegant way to achieve this: using  `suspend`  and  `coroutineScope`

<script src="https://gist.github.com/jorgecasariego/2686abe345bd3a0098725ed6612bd1a3.js"></script>

```
[main] Start
[DefaultDispatcher-worker-1] Hello1
[main] Done
```

The new scope created by  `coroutineScope`  inherits the context from the outer scope.

### CoroutineScope extension vs suspend

The previous example (using  `suspend`) can be rewritten using  `CoroutineScope`  extension:

<script src="https://gist.github.com/jorgecasariego/ba75a21f1a2f8039610291bbcf656fc2.js"></script>

```
[main] Start
[main] Done
[DefaultDispatcher-worker-1] Hello1
```

The output though is not the same! why? Here is the rules:

-   `suspend`: function do something long and waits for it to complete without blocking.
-   Extension of  `CoroutineScope`: function launch new coroutines and quickly return without waiting for them.
## Coroutine Context and Dispatchers

Coroutines always execute in some  `CoroutineContext`. The coroutine context is a set of various elements. The main elements are the  `Job`  of the coroutine and its  `CoroutineDispatcher`.

### Dispatchers

`CoroutineContext`  _includes_  a  `CoroutineDispatcher`  that determines what thread or threads the corresponding coroutine uses for its execution. Coroutine dispatcher can confine coroutine execution to a  _specific thread_, dispatch it to a  _thread pool,_  or let it run  _unconfined_.

Coroutine builders  `launch`,  `async`  and  `withContext`  accept an  `CoroutineContext`  parameter that can be used to explicitly specify the  _dispatcher_  for new coroutine (and other context elements).

Here is various implementations of  `CoroutineDispatcher`:

-   `Dispatchers.Default`: the default dispatcher, that is used when coroutines are launched in  `GlobalScope`. Uses shared background pool of threads, appropriate for  _compute-intensive_  coroutines.
-   `Dispatchers.IO`: Uses a shared pool of on-demand created thread. Designed for IO-intensive  _blocking_  operations.
-   `Dispatchers.Unconfined`: Unrestricted to any specific thread or pool. Can be useful for some really special cases, but should not be used in general code.

<script src="https://gist.github.com/jorgecasariego/bb6731107eb36315f48ad824691713a2.js"></script>

```
[main] Start
[DefaultDispatcher-worker-2] Dispatchers.Default
[DefaultDispatcher-worker-1] Dispatchers.IO
[main] Dispatchers.Unconfined
[main] from parent dispatcher
[main] Done
```

(`Dispatcher.IO`  _dispatcher shares threads with_  `Dispatchers.Default`)

## Coroutine Scope

Each coroutine run inside a  _scope_. A scope can be application wide or specific. But why this is needed ?  
Contexts and jobs lifecycles are often tied to objects who are not coroutines (_Android activities for example_). Managing coroutines lifecycles can be done by keeping references and handling them manually. However, a better approach is to use  `CoroutineScope`.  
Best way to create a  `CoroutineScope`  is using:

-   `CoroutineScope()`: creates a general-purpose scope.
-   `MainScope()`: creates scope for UI applications and uses  `Dispatchers.Main`  as default dispatcher.

```
Start
[DefaultDispatcher-worker-1] doing something...
[DefaultDispatcher-worker-3] doing something...
[DefaultDispatcher-worker-2] doing something...
[DefaultDispatcher-worker-2] doing something...
Done
```

Only the first four coroutines had printed a message and the others were cancelled by a single invocation of  `CoroutineScope.cancel()`  in  `Activity.destroy()`.

Alternatively, we can implement  `CoroutineScope`  interface in this  `Activity`  class, and use delegation with default factory function:

<script src="https://gist.github.com/jorgecasariego/2231bc86558648fca4ea50f740fb984e.js"></script>

## Conclusion

Coroutines are a very good way to achieve  [asynchonous programming with kotlin](https://github.com/Kotlin/kotlinx.coroutines/blob/master/docs/composing-suspending-functions.md).  
The following is an (over)simplified diagram of coroutines structure while keeping in mind each  `Element`  _is_  a  `CoroutineContext`  by its own:

![coroutines structure](https://mouaad.aallam.com/assets/images/blog/coroutines_structure.svg)



Source:
- [https://kotlinlang.org/docs/reference/coroutines/coroutine-context-and-dispatchers.html](https://kotlinlang.org/docs/reference/coroutines/coroutine-context-and-dispatchers.html)
- [https://mouaad.aallam.com/kotlin-coroutines-basics/](https://mouaad.aallam.com/kotlin-coroutines-basics/)
- [https://proandroiddev.com/async-operations-with-kotlin-coroutines-part-1-c51cc581ad33](https://proandroiddev.com/async-operations-with-kotlin-coroutines-part-1-c51cc581ad33)
