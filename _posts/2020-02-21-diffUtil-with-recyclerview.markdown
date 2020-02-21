---
title: "Using DiffUtil in Android RecyclerView"
layout: post
date: 2020-02-21 09:52
image: 
headerImage: false
tag:
- android
- DiffUtil
category: blog
author: jorgecasariego
description: DiffUtil is a utility class that can calculate the difference between two lists and output a list of update operations that converts the first list into the second one.It can be used to calculate updates for a RecyclerView Adapter.
---

## The notifyDataSetChanged() method is inefficient

To tell `RecyclerView` that an item in the list has changed and needs to be updated, the current code calls [`notifyDataSetChanged()`](https://developer.android.com/reference/android/widget/BaseAdapter) in the `SleepNightAdapter`, as shown below.

```kotlin
var data =  listOf<SleepNight>()
   set(value) {
       field = value
       notifyDataSetChanged()
   }
```
However,  `notifyDataSetChanged()`  tells  `RecyclerView`  that the entire list is potentially invalid. As a result,  `RecyclerView`  rebinds and redraws every item in the list, including items that are not visible on screen. This is a lot of unnecessary work. For large or complex lists, this process could take long enough that the display flickers or stutters as the user scrolls through the list.

To fix this problem, you can tell  `RecyclerView`  exactly what has changed.  `RecyclerView`  can then update only the views that changed on screen.

`RecyclerView`  has a rich API for updating a single element. You could use  [`notifyItemChanged()`](https://developer.android.com/reference/android/support/v7/widget/RecyclerView.Adapter#notifyitemchanged)  to tell  `RecyclerView`  that an item has changed, and you could use similar functions for items that are added, removed, or moved. You could do it all manually, but that task would be non-trivial and might involve quite a bit of code.

Fortunately, there's a better way.

## DiffUtil is efficient and does the hard work for you
`RecyclerView`  has a class called  `DiffUtil`  which is for calculating the differences between two lists.  `DiffUtil`  takes an old list and a new list and figures out what's different. It finds items that were added, removed, or changed. Then it uses an algorithm called a  [Eugene W. Myers's difference algorithm](https://en.wikipedia.org/wiki/Diff)  to figure out the minimum number of changes to make from the old list to produce the new list.

Once  `DiffUtil`  figures out what has changed,  `RecyclerView`  can use that information to update only the items that were changed, added, removed, or moved, which is much more efficient than redoing the entire list.

## Refresh list content with DiffUtil
In order to use the functionality of the `DiffUtil` class, extend `DiffUtil.ItemCallback`.

<script src="https://gist.github.com/jorgecasariego/995d691f6724945f00fbc1593540c5f4.js"></script>

1.  Put the cursor in the  `SleepNightDiffCallback`  class name.
2.  Press  `Alt+Enter`  (`Option+Enter`  on Mac) and select **Implement Members**.
3.  In the dialog that opens, shift-left-click to select the  `areItemsTheSame()`  and  `areContentsTheSame()`  methods, then click  **OK**.

<script src="https://gist.github.com/jorgecasariego/c204b9eea0978f949b306202a3531e6f.js"></script>

4.  Inside `areItemsTheSame()`, replace the `TODO` with code that tests whether the two passed-in `SleepNight` items, `oldItem` and `newItem`, are the same. If the items have the same `nightId`, they are the same item, so return `true`. Otherwise, return `false`. `DiffUtil` uses this test to help discover if an item was added, removed, or moved

```kotlin
override fun areItemsTheSame(oldItem: SleepNight, newItem: SleepNight): Boolean {
   return oldItem.nightId == newItem.nightId
}
```

5.  Inside `areContentsTheSame()`, check whether `oldItem` and `newItem` contain the same data; that is, whether they are equal. This equality check will check all the fields, because `SleepNight` is a data class. `Data` classes automatically define `equals` and a few other methods for you. If there are differences between `oldItem` and `newItem`, this code tells `DiffUtil` that the item has been updated.

```kotlin
override fun areContentsTheSame(oldItem: SleepNight, newItem: SleepNight): Boolean {
   return oldItem == newItem
}
```

## Use ListAdapter to manage your list
It's a common pattern to use a  `RecyclerView`  to display a list that changes.  `RecyclerView`  provides an adapter class,  `ListAdapter`, that helps you build a  `RecyclerView`  adapter that's backed by a list.

`ListAdapter`  keeps track of the list for you and notifies the adapter when the list is updated.

1.  Change the class signature of  your Adapter  to extend  `ListAdapter`.
2.  If prompted, import  `androidx.recyclerview.widget.ListAdapter`.
3.  Add  `SleepNight`  as the first argument to the  `ListAdapter`, before  `SleepNightAdapter.ViewHolder`.
4.  Add  `SleepNightDiffCallback()`  as a parameter to the constructor. The  `ListAdapter`  will use this to figure out what changed in the list. Your finished  `SleepNightAdapter`  class signature should look as shown below

```kotlin
class SleepNightAdapter : ListAdapter<SleepNight, SleepNightAdapter.ViewHolder>(SleepNightDiffCallback()) {
```

## keep the list updated
Your code needs to tell the `ListAdapter` when a changed list is available. `ListAdapter` provides a method called `submitList()` to tell `ListAdapter` that a new version of the list is available. When this method is called, the `ListAdapter` diffs the new list against the old one and detects items that were added, removed, moved, or changed. Then the `ListAdapter` updates the items shown by `RecyclerView`.

In your fragment tell the adapter when your data has been updated:

```
sleepTrackerViewModel.nights.observe(viewLifecycleOwner, Observer {
   it?.let {
       adapter.submitList(it)
   }
})
```

Now run your app. It runs faster, maybe not noticeably if your list is small.
