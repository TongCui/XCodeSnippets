# Mastering Swift 3
2016 Packt Publishing

Author : Jon Hoffman

You can follow Jon on his two blogs: http://masteringswift.blogspot.com and http://myroboticadventure.blogspot.com.

 www.PacktPub.com

#### Downloading the example code
https://github.com/PacktPublishing/Mastering-Swift-3.

https://github.com/PacktPublishing/

## Chapter 1. Taking the First Steps with Swift


#### Documentation
```
///
///	The xxx function will take two integers, add
/// them together and return the sum
/// - parameter first:
/// - parameter second:
/// - returns:
///	- throws:
```

#### print
```
var name1 = "Jon" 
var name2 = "Kim" 
var name3 = "Kailey" 
var name4 = "Kara" 
// Jon, Kim, Kailey, Kara
print(name1, name2, name3, name4, separator:", ", terminator:"") 

var line = ""
print(name1, name2, name3, name4, separator:", ", terminator:"", to:&line)
```

## Chapter 2. Learning About Variables, Constants, Strings, and Operators

#### Floating point

The Double type has a precision of at least 15 decimal digits, while the Float type can be as little as six decimal digits.


## Chapter 3. Using Swift Collections and the Tuple Type


## Chapter 4. Control Flow and Functions

Curly brackets are required for conditional statements and loop;
Paratheses is optional

#### Filtering with the for-case statement

```
var worldSeriesWinners = [ 
    ("Red Sox", 2004), 
    ("White Sox", 2005), 
    ("Cardinals", 2006), 
    ("Red Sox", 2007), 
    ("Phillies", 2008), 
    ("Yankees", 2009), 
    ("Giants", 2010), 
    ("Cardinals", 2011), 
    ("Giants", 2012), 
    ("Red Sox", 2013), 
    ("Giants", 2014), 
    ("Royals", 2015) 
] 
 
for case let ("Red Sox", year) in worldSeriesWinners { 
    print(year) 
} 
```

```
let myNumbers: [Int?] = [1, 2, nil, 4, 5, nil, 6] 
 
for case let num? in myNumbers where num > 3 { 
    print(num) 
} 

```

#### Using the if-case statement

```
enum Identifier { 
    case Name(String) 
    case Number(Int) 
    case NoIdentifier 
} 
 
var playerIdentifier = Identifier.Number(2) 
 
if case let .Number(num) = playerIdentifier { 
    print("Player's number is \(num)") 
} 
```

## Chapter 5. Classes and Structures

#### Differences between classes and structures

- Type: A structure is a value type, while a class is a reference type
- Inheritance: A structure cannot inherit from other types, while a class can
- Deinitializers: Structures cannot have custom deinitializers, while a class can

To illustrate the difference between value and reference types, let's look at a real-world object—a book. If we have a friend who wants to read Mastering Swift, we could either buy them their own copy or share ours.

#### Property observers

Property observers are called every time the value of the property is set. We can add property observers to any non-lazy stored property. We can also add property observers to any inherited stored or computed property by overriding the property in the subclass. 

## Chapter 6. Using Protocols and Protocol Extensions

#### Type casting with protocols

```
for person in people { 
  if person is SwiftProgrammer { 
     print("\(person.firstName) is a Swift Programmer") 
  } 
} 

for person in people { 
    switch (person) { 
    case is SwiftProgrammer: 
        print("\(person.firstName) is a Swift Programmer") 
    case is FootballPlayer: 
        print("\(person.firstName) is a Football Player") 
    default: 
        print("\(person.firstName) is an unknown type") 
    } 
} 

for person in people where person is SwiftProgrammer { 
    print("\(person.firstName) is a Swift Programmer") 
 
} 


```

The Swift API Design Guidelines (https://swift.org/documentation/api-design-guidelines/) state that protocols that describe what something is should be named as a noun while protocols that describe a capability should be named with using a suffix of -able, -ible or -ing. With this in mind, we will name our text validation protocol TextValidating.

## Chapter 7. Protocol-Oriented Design

## Chapter 8. Writing Safer Code with Availability and Error Handling

```
if #available(iOS 9.0, OSX 10.10, watchOS 2, *) { 
     // Available for iOS 9, OSX 10.10, watchOS 2 or above 
    print("Minimum requirements met") 
} else { 
    //  Block on anything below the above minimum requirements 
    print("Minimum requirements not met") 
} 

@available(iOS 9.0, *) 
func testAvailability() { 
    // Function only available for iOS 9 or above 
} 
```

## Chapter 9. Custom Subscripting

## Chapter 10. Using Optional Types

## Chapter 11. Working with Generics

## Chapter 12. Working with Closures

## Chapter 13. Using Mix and Match

Using Obj-C to swift code. [ProjectName]-Bridging-Header.h
Using swift to Obj-C code. [ProjectName]-Swift.h

## Chapter 14. Concurrency and Parallelism in Swift

## Chapter 15. Swift Formatting and Style Guide

## Chapter 16. Swifts Core Libraries

|DateFormatter Style|Date|Time|
|---|---|---|
|.none|No format| No format|
|.short|12/25/16| 6:00 AM|
|.medium|Dec 25, 2016| 6:00:00 AM|
|.long|Decenber 25,2016| 6:00:00 AM EST|
|.full|Sunday December 25, 2016| 6:00:00 AM Eastern Standard Time|


|Stand-in Format|Description|Example Output|
|---|---|---|
|yy|year|16|
|yyyy|year|2016|
|MM|month|01|
|MMM|month|Jan|
|MMMM|month|August|
|dd|day|10|
|EEE|day|Monday|
|a|Period of day|AM,PM|
|hh|hour|10|
|HH|hour|21|
|mm|minute|10|
|ss|seconds|10|








