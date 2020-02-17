---
title: "ViewModels on Android "
layout: post
date: 2020-02-17 14:08
image: 
headerImage: false
tag:
- android
- Jetpack
category: blog
author: jorgecasariego
description: ViewModel Overview
---
  
## Description  
  
The Android framework manages the lifecycles of UI controllers, such as activities and fragments. The framework may decide to destroy or re-create a UI controller in response to certain user actions or device events that are completely out of your control.

If the system destroys or re-creates a UI controller, any transient UI-related data you store in them is lost. For example, your app may include a list of users in one of its activities. When the activity is re-created for a configuration change, the new activity has to re-fetch the list of users. For simple data, the activity can use the  `[onSaveInstanceState()](https://developer.android.com/reference/android/app/Activity.html#onSaveInstanceState(android.os.Bundle))`  method and restore its data from the bundle in  `[onCreate()](https://developer.android.com/reference/android/app/Activity.html#onCreate(android.os.Bundle))`, but this approach is only suitable for small amounts of data that can be serialized then deserialized, not for potentially large amounts of data like a list of users or bitmaps.

Another problem is that UI controllers frequently need to make asynchronous calls that may take some time to return. The UI controller needs to manage these calls and ensure the system cleans them up after it's destroyed to avoid potential memory leaks. This management requires a lot of maintenance, and in the case where the object is re-created for a configuration change, it's a waste of resources since the object may have to reissue calls it has already made.

UI controllers such as activities and fragments are primarily intended to display UI data, react to user actions, or handle operating system communication, such as permission requests. Requiring UI controllers to also be responsible for loading data from a database or network adds bloat to the class. Assigning excessive responsibility to UI controllers can result in a single class that tries to handle all of an app's work by itself, instead of delegating work to other classes. Assigning excessive responsibility to the UI controllers in this way also makes testing a lot harder.

It's easier and more efficient to separate out view data ownership from UI controller logic. 
  
## State restoration on Android Development  
  
State restoration has always been one of the most annoying aspects of Android development. By default, activities  and fragments have an onSaveInstanceState() method that the system uses to provide a Bundle to which you can write  primitive data and parcelable (or serializable) objects. That same Bundle is then provided once the UI component is   
being recreated, and that’s when you usually read all the data from the Bundle and update the UI.  
  
This is all well and good as long as you’re managing simple data, such as strings or primitive values. But problems start to occur once you need to restore something more complex — something more memory demanding, such as bitmaps, or maybe some asynchronous process that’s currently running.

> Problems start to occur once you need to restore something more
> complex — something more memory demanding, such as bitmaps, or maybe some asynchronous process that’s currently running.

What you would usually do is either use loaders or store objects to some static classes. But loaders have been deprecated in favor of ViewModels, as the [loaders documentation](https://developer.android.com/guide/components/loaders) nicely explains:

> Loaders have been deprecated as of Android P (API 28). The recommended
> option for dealing with loading data while handling the activity and
> fragment lifecycles is to use a combination of `ViewModels` and
> `LiveData`. ViewModels survive configuration changes like Loaders but with less boilerplate. LiveData provides a lifecycle-aware way of
> loading data that you can reuse in multiple ViewModels…ViewModels and LiveData are also available in situations where you do not have access to the `LoaderManager`, such as in a `Service`. Using the two in tandem provides an easy way to access the data your app needs without having to deal with the UI lifecycle.

## The lifecycle of a ViewModel

[`ViewModel`](https://developer.android.com/reference/androidx/lifecycle/ViewModel.html)  objects are scoped to the  [`Lifecycle`](https://developer.android.com/reference/androidx/lifecycle/Lifecycle.html)  passed to the  [`ViewModelProvider`](https://developer.android.com/reference/androidx/lifecycle/ViewModelProvider.html)  when getting the  [`ViewModel`](https://developer.android.com/reference/androidx/lifecycle/ViewModel.html). The  [`ViewModel`](https://developer.android.com/reference/androidx/lifecycle/ViewModel.html)  remains in memory until the  [`Lifecycle`](https://developer.android.com/reference/androidx/lifecycle/Lifecycle.html)  it's scoped to goes away permanently: in the case of an activity, when it finishes, while in the case of a fragment, when it's detached.

Figure 1 illustrates the various lifecycle states of an activity as it undergoes a rotation and then is finished. The illustration also shows the lifetime of the  [`ViewModel`](https://developer.android.com/reference/androidx/lifecycle/ViewModel.html)  next to the associated activity lifecycle. This particular diagram illustrates the states of an activity. The same basic states apply to the lifecycle of a fragment.

![Illustrates the lifecycle of a ViewModel as an activity changes state.](https://developer.android.com/images/topic/libraries/architecture/viewmodel-lifecycle.png)


You usually request a [`ViewModel`](https://developer.android.com/reference/androidx/lifecycle/ViewModel.html) the first time the system calls an activity object's `[onCreate()](https://developer.android.com/reference/android/app/Activity.html#onCreate(android.os.Bundle))` method. The system may call `[onCreate()](https://developer.android.com/reference/android/app/Activity.html#onCreate(android.os.Bundle))` several times throughout the life of an activity, such as when a device screen is rotated. The [`ViewModel`](https://developer.android.com/reference/androidx/lifecycle/ViewModel.html) exists from when you first request a [`ViewModel`](https://developer.android.com/reference/androidx/lifecycle/ViewModel.html) until the activity is finished and destroyed.


### Getting a ViewModel Instance

In order to get an instance of  [`ViewModel`](https://developer.android.com/reference/android/arch/lifecycle/ViewModel), first you need to get the  [`ViewModelProvider`](https://developer.android.com/reference/android/arch/lifecycle/ViewModelProvider)  object for your particular UI component. You do this via one of the static methods,  [`ViewModelProviders.of()`](https://developer.android.com/reference/android/arch/lifecycle/ViewModelProviders), which takes your UI component as an argument and returns its respective  [`ViewModelProvider`](https://developer.android.com/reference/android/arch/lifecycle/ViewModelProvider). After that, calling  `get(YourViewModel::class.java)`  on your  [`ViewModelProvider`](https://developer.android.com/reference/android/arch/lifecycle/ViewModelProvider)  will give you the requested  [`ViewModel`](https://developer.android.com/reference/android/arch/lifecycle/ViewModel)  instance. The  [`ViewModelProvider`](https://developer.android.com/reference/android/arch/lifecycle/ViewModelProvider)  is bound to that UI component, which means it reacts to its lifecycle changes accordingly.

**Note:** Providers for different UI components will create different [`ViewModel`](https://developer.android.com/reference/android/arch/lifecycle/ViewModel) instances, even if they use the same [`ViewModel`](https://developer.android.com/reference/android/arch/lifecycle/ViewModel) class.

A sample initialization would look like this:

{ % gist jorgecasariego/158f075e823407af5ea7ebdf8b9060c6 % }

<script src="https://gist.github.com/jorgecasariego/158f075e823407af5ea7ebdf8b9060c6.js"></script>

Here we’ve created a  [`ViewModel`](https://developer.android.com/reference/android/arch/lifecycle/ViewModel)  tied to  `MyFragment`. This means that this  [`ViewModel`](https://developer.android.com/reference/android/arch/lifecycle/ViewModel)  is aware of the lifecycle of  `MyFragment`  and it will be retrieved with the previous state only if it’s provided for that fragment.  `MyViewModel`  can also be provided for some other fragment or activity, but in such a case, the new instance would be created for each of the components.

### Showcasing a Simple State Restoration

To understand how the state is restored

{ % gist jorgecasariego/6448f9d3c07219c3a34569b6f821c385 % }

<script src="https://gist.github.com/jorgecasariego/6448f9d3c07219c3a34569b6f821c385.js"></script>

In this example,  `MyViewModel`  has the  `getImage()`  method the UI components can use to get an image from the web.  `MyViewModel`  will also cache the image when downloaded so it doesn’t have to be downloaded more than once.

**Note:**  The above example serves the purpose of demonstrating that the  `ViewModel`  is restored when the configuration changes. The image downloading should be offloaded from the main thread,  `LiveData`  should be used, etc. We will improve this example when we introduce  `LiveData`  in the next section.

Now in  `MyFragment`, let’s create a layout that has an  `ImageView`  that simply shows the downloaded image once the fragment is loaded:

{ % gist jorgecasariego/9cb117832c32b30aed93f807dedc98b1 % }

<script src="https://gist.github.com/jorgecasariego/9cb117832c32b30aed93f807dedc98b1.js"></script>

The first time  `getImage()`  is called, the image will be downloaded. When the configuration changes — for example, if the screen orientation changes — the image will be loaded into the  `ImageView`  from cache, since the  [`ViewModel`](https://developer.android.com/reference/android/arch/lifecycle/ViewModel)  object is retained.

### Restoring State with LiveData

What is  [`LiveData`](https://developer.android.com/reference/android/arch/lifecycle/LiveData)? Here’s the definition from the  [LiveData Overview](https://developer.android.com/topic/libraries/architecture/livedata)  section in the Android guides:

> [`LiveData`](https://developer.android.com/reference/android/arch/lifecycle/LiveData)  is an observable data holder class. Unlike a regular observable,  [`LiveData`](https://developer.android.com/reference/android/arch/lifecycle/LiveData)  is lifecycle-aware, meaning it respects the lifecycle of other app components, such as activities, fragments, or services. This awareness ensures LiveData only updates app component observers that are in an active lifecycle state.

[`LiveData`](https://developer.android.com/reference/android/arch/lifecycle/LiveData)  is the proper way UI components should receive input from the ViewModels.  [`LiveData`](https://developer.android.com/reference/android/arch/lifecycle/LiveData), being an observable data holder class, is provided to the UI components by its  [`ViewModel`](https://developer.android.com/reference/android/arch/lifecycle/ViewModel), and the UI component can subscribe to it and listen for the streamed results.

Let’s update our initial example where we retrieve the image to be displayed in the  `ImageView`, this time using  [`LiveData`](https://developer.android.com/reference/android/arch/lifecycle/LiveData). This is the outline of our  `ViewModel`  now:

{ % gist jorgecasariego/5640298d202701117b73bf1a8491d1e4 % }

<script src="https://gist.github.com/jorgecasariego/5640298d202701117b73bf1a8491d1e4.js"></script>

This time, the  `getImage()`  method doesn’t return anything, and it will just be called from the UI component to start retrieving the image. Once the image is retrieved, either by being downloaded or pulled from the cache, it will be pushed to the  `imageLiveData`  object and delivered to all of its subscribers. Notice that  `ViewModel`  doesn’t care who is subscribed; it just emits the result.

The  `MyFragment`  implementation will now look like this:

{ % gist jorgecasariego/53920cca8ae8bbd4ba25e7b278ec534e % }

<script src="https://gist.github.com/jorgecasariego/53920cca8ae8bbd4ba25e7b278ec534e.js"></script>

A `ViewModel` needs to call [`setValue()`](https://developer.android.com/reference/android/arch/lifecycle/LiveData#setvalue) (or [`postValue()`](https://developer.android.com/reference/android/arch/lifecycle/LiveData#postvalue) if not on main thread) on the `LiveData` object to push the given value to all of the observers. Here’s the sample implementation for our case:

{ % gist jorgecasariego/c7dba55f939948ce4dbb4ecc03108d24 % }

<script src="https://gist.github.com/jorgecasariego/c7dba55f939948ce4dbb4ecc03108d24.js"></script>

That’s it. If there happens to be a configuration change while the image is being downloaded, the download process will continue being executed, since  `MyViewModel`  is not destroyed.

Once the UI is recreated and  `getImage()`  is called,  `MyViewModel`  will check if there was already a value pushed to the  `imageLiveData`  object. If so, it will push it again so that subscribers can consume it. If not, it will check if the download process has already started. If it hasn’t, it starts the new one. If it has, the running operation will post the result to the  `imageLiveData`  once it’s done.

If you happen to hold some RxJava  `Disposable`  or a handle to the download process itself, you can override  `ViewModel`’s  [`onCleared()`](https://developer.android.com/reference/android/arch/lifecycle/ViewModel#oncleared)  method and perform the clearance there. That method is called when the UI component related to it is destroyed and the resources can be safely cleared.

## Conclusion

Easier state restoration is just a consequence of the  `ViewModel`  implementation. ViewModels should serve a much wider purpose in your app than just restoring state. They should separate the business logic from the UI and deliver data to the UI using the observer pattern.

Being aware of the lifecycle of UI components and having a very nice syntax is a powerful tool when it comes to retaining objects and processes related to a particular UI component. This is also helpful when you need to dispose of them, clean up the memory resources, or prevent some state restoration bugs.

----
**References**

 - [Android Developer](https://developer.android.com/topic/libraries/architecture/viewmodel)
 - Example:  [Using ViewModels to Retain State on Android](https://pspdfkit.com/blog/2019/using-viewmodels-to-retain-state-on-android/)
