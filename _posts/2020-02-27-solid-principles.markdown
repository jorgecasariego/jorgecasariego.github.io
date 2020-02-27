---
title: "SOLID principles with Kotlin"
layout: post
date: 2020-02-27 16:03
image: 
headerImage: false
tag:
- design
- OOP
category: blog
author: jorgecasariego
description: SOLID Principles is a coding standard that all developers should have a clear concept for developing software in a proper way to avoid a bad design. It was promoted by Robert C Martin and is used across the object-oriented design spectrum. When applied properly it makes our code more extendable, logical and easier to read.
---

# SOLID principles with Kotlin

## S — Single Responsibility Principle

_A class should only have a single responsibility, that is, only changes to one part of the software’s specification should be able to affect the specification of the class._

An example of violating Single Responsibility Principle:

<script src="https://gist.github.com/jorgecasariego/216b8b060cb47afe992db889f2741f2f.js"></script>

The example above violates the single responsibility principle is because class  _Yerba_  have two responsibilities: Properties management responsibility and Database management responsibility.

To resolve this, we can separate the responsibilities into two different classes:

```kotlin
class Yerba (val name: String, val brand: String){}
```

```kotlin
class DbUtils (val db: Database){  
	fun saveYerbaToDb(yerba: Yerba) {  
		db.save(yerba)  
	}  
}
```

# O — Open/Closed Principle

> _Software entities such as classes, functions, modules should be open for extension but not modification._

An example of violating Open/Closed Principle:

```kotlin
class Yerba (val name: String){  
    fun getBrand(): String {  
        when(name){  
            "kurupi" ->{return "Yerba Kurupí"}  
            "campesino" -> {return "Yerba Campesino"}  
        }  
    }  
}
```

The example above violates open/closed principle is because class  _Yerba_  does not apply to every yerba in the Market. Think about what will happen if the yerba name is "pajarito".

To resolve this, we can create an interface of class Yerba

```kotlin
interface Yerba {  
    fun getBrand(): String  
}
```

and Yerba with different name can extends from the class above

```kotlin
class Kurupi: Yerba{  
    override fun getBrand(): String {  
        return "Yerba Kurupi"  
    }  
}

class Campesino: Yerba{  
    override fun getBrand(): String {  
        return "Yerba Campesino"  
    }  
}

class Pajarito: Yerba{  
    override fun getBrand(): String {  
        return "Yerba Pajarito"  
    }  
}
```

# L — Liskov substitution principle

> _Objects in a program should be replaceable with instances of their subtypes without altering the correctness of that program._

A very good example of violating Liskov substitution principle is shown as below:

```kotlin
class Rectangle {  
    private var width: Int = 0  
    private var height: Int = 0
    
    fun getArea(): Int {  
        return width * height  
    } 
	fun setWidth(width: Int) {  
        this.width = width  
    } 
    fun setHeight(height: Int) {  
        this.height = height  
    }  
}

class Square : Rectangle() {  
    override fun setWidth(width: Int) {  
        super.setWidth(width)  
        super.setHeight(width)  
    }  
  
   override fun setHeight(height: Int) {  
        super.setWidth(height)  
        super.setHeight(height)  
    }  
}

val rectangle = Rectangle()  
rectangle.setWidth(3)  
rectangle.setHeight(5)  
rectangle.getArea() = 15

val square = Square()  
square.setWidth(3)  
square.setHeight(5)  
square.getArea() = 25
````

getArea() will return as different value for a square object and a rectangle object, hence violating the rule  _without altering the correctness of that program._ To resolve this, what we can do is treat them as a different shape

```kotlin
interface Shape {  
    fun getArea(): Int  
}
class Rectangle: Shape {  
	    private var width: Int = 0  
	    private var height: Int = 0 
	
	override fun getArea(): Int {  
        return width * height  
    } 
	
	fun setWidth(width: Int) {  
        this.width = width  
    } 
	
	fun setHeight(height: Int) {  
        this.height = height  
    }  
}

class Square: Shape {  
    private var diameter: Int = 0  
      
    override fun getArea(): Int {  
        return diameter * diameter  
    } 

	fun setDiameter(diameter: Int) {  
        this.diameter = diameter  
    }  
}

val rectangle = Rectangle()  
rectangle.setWidth(3)  
rectangle.setHeight(5)  
rectangle.getArea() = 15

val square = Square()  
square.setDiamater(5)  
square.getArea() = 25
```

# I — Interface segregation principle

> _Many client-specific interfaces are better than one general-purpose interface._

A very good example of violating Interface segregation principle is shown as below:

```kotlin
interface Person {  
    fun code()  
    fun cook()  
    fun build() 
    fun eat()
}

class DevPerson: Person {  
    override fun code() {doCode()}  
    override fun cook() {}  
    override fun build() {} 
	override fun eat(){doEat()}  
}

class CheftPerson: Person {  
    override fun code() {}  
    override fun cook() {doCook()}  
    override fun build() {} 
    override fun eat(){doEat()}  
}

class EngineerPerson: Person {  
    override fun code() {}  
    override fun cook() {}  
    override fun build({doBuild()} 
    override fun eat(){doEat()}  
}
```

As shown in above, for EngineerPerson class, only build and eat function is being implemented; whereas code function and cook function has no functionality. To resolve this, we should create multiple interfaces, such as

```kotlin
interface Person {  
    fun eat()  
}

interface DevPerson: Person {  
    fun code()  
}
interface CheftPerson: Person {  
    fun cook()  
}
interface EngineerPerson: Person {  
    fun build()  
}

class DevPersonImpl: DevPerson {  
    override fun code() {doCode()}  
    override fun eat(){doEat()}  
}

class CheftPersonImpl: CheftPerson {  
    override fun cook() {doCook()}  
    override fun eat(){doEat()}  
}

class EngineerPersonImpl: EngineerPerson {  
    override fun build() {doBuild()}  
    override fun eat(){doEat()}  
}
```

# D — Dependency inversion principle

> _High-level modules should not depend on low-level modules. Both should depend on abstractions._
> 
> _Abstractions should not depend on details. Details should depend on abstractions._

An example of violating Dependency inversion principle:

```kotlin
interface Yerba{  
    fun getBrand(): String  
}

class Kurupi: Yerba {  
    override fun getBrand() {  
        return "Yerba Kurupi"  
    }  
}

class YerbaTest(val yerba: Kurupi) {  
    fun getYerbaBrand() { 
	    return yerba.getBrand() 
	}  
}
```

The example above violates first rule of dependency inversion principle. High-level modules should not understand the actual implementation of low-level modules. They should only communicate through abstractions. To resolve this, we should pass in the interface instead of the class

```kotlin
interface Yerba{  
    fun getBrand(): String  
}

class Kurupi {  
    override fun getBrand() {  
        return "Yerba Kurupi"  
    }  
}

class YerbaTest(val yerba: Yerba) {  
    fun getYerbaBrand() { 
	    return fruit.getColor() 
	}  
}
```

## Benefits
This approach will lead to cleaner, more manageable code that can be easily unit tested, which in turn can allow for rapid development as it allows a more methodical approach.

These rules will greatly benefit any project and should be heavily considered along with other agile methodologies.

## Drawbacks
It may make life easier for developers if it is included from the outset of a project. But trying to bend existing projects to fit this approach could potentially be near impossible.

# Conclusion

Writing code in SOLID principles manner will make our software more readable, understandable, flexible and maintainable.
