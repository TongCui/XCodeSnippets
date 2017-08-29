#### Source Code

[Github](git@github.com:PacktPublishing/Swift-3-Functional-Programming.git)

#### Functional Programming
functional programming paradigms, such as immutability, stateless programming, pure, first-class, and higher-order functions.

#### SOLID
single responsibility, open-closed, Liskov substitution, interface segregation and dependency inversion (SOLID)

#### What
Functional programming is a declarative programming style, as opposed to OOP that is categorized as imperative programming.

Theoretically, functional programming employs the concepts of category theory, which is a branch of mathematics. It is not necessary to know the category theory to be able to program functionally but studying it will help us grasp some of the more advanced concepts such as functors, applicative functors, and monads.

```
let numbers = [9, 29, 19, 79]

// Imperative example
var tripledNumbers:[Int] = []
for number in numbers {
    tripledNumbers.append(number * 3)
}
print(tripledNumbers)

// Declarative example
let tripledIntNumbers = numbers.map({ number in 3 * number })
print(tripledIntNumbers)
```

#### lazily

in the following code example, only the first element in the array is evaluated:
```
let oneToFour = [1, 2, 3, 4]
let firstNumber = oneToFour.lazy.map({ $0 * 3}).first!
print(firstNumber) // The result is going to be 3
```

#### String interpolation
"\(value)"


#### Classes versus structures
This section compares classes and structures:

- Inheritance enables one class to inherit the characteristics of another
- Type casting enables us to check and interpret the type of a class instance at runtime
- Deinitializers enable an instance of a class to free any resources it has assigned
- Reference counting allows more than one reference to a class instance
- Structures are value types so they are always copied when they are passed around in code
- Structures do not use reference counting
- Classes are reference types


#### you aren't gonna need it (YAGNI).

#### Function composition

A composed function with a custom operator

```
infix operator |> { associativity left }
func |> <T, V>(f: T -> V, g: V -> V ) -> T -> V {
    return { x in g(f(x)) }
}

let composedWithCustomOperator = extractElements |> formatWithCurrency
composedWithCustomOperator("10,20,40,30,80,60")
```

#### Function currying
Function currying translates a single function with multiple arguments into a series of functions each with one argument. 

```
func explicityRetunClosure(firstName: String) -> (String) -> String {
    return { (lastName: String) -> String in
        return "\(firstName) \(lastName)"
    }
}

```

#### Tail recursion
Tail recursion is a special case of recursion where the calling function does no more execution after making a recursive call to itself. In other words, a function is named tail recursive if its final expression is a recursive call.

Not

```
func factorial(n: Int) -> Int {
    return n == 0 || n == 1 ? 1 : n * factorial(n: n - 1)
}

print(factorial(n: 3))
```

YES

```
func factorial(n: Int, currentFactorial: Int = 1) -> Int {
    return n == 0 ? currentFactorial : factorial(n: n - 1,
      currentFactorial: currentFactorial * n)
}

print(factorial(n: 3))
```

Let's try to understand how it works and how it is different from the other factorial function:
```
factorial(n: 3, currentFactorial: 1)
return factorial(n: 2, currentFactorial: 1 * 3) // n = 3
return factorial(n: 1, currentFactorial: 3 * 2) // n = 2
return 6 // n = 1
```

Therefore, a function is tail recursive if the final result of the recursive call—in this example, 6—is also the final result of the function itself. The non-tail recursive function is not in its final state in the last function call because all of the recursive calls leading up to the last function call must also return in order to actually come up with the final result.


#### memoization
In computing, memoization is an optimization technique used primarily to speed up computer programs by having function calls avoid repeating the calculation of results for previously processed inputs.

Memoization is the process of storing the result of functions, given their input, in order to improve the performance of our programs. We can memoize pure functions as pure functions do not rely on external data and do not change anything outside themselves. Pure functions provide the same result for a given input every time. 

```
var memo = Dictionary<Int, Int>()

func memoizedPower2(n: Int) -> Int {
    if let memoizedResult = memo[n] {
        return memoizedResult
    }
    var y = 1
    for _ in 0...n-1 {
        y *= 2
    }
    memo[n] = y
    return y
}
print(memoizedPower2(n: 2))
print(memoizedPower2(n: 3))
print(memoizedPower2(n: 4))
print(memo) // result: [2: 4, 3: 8, 4: 16]
```

The advanced Swift session presented in Worldwide Developers Conference (WWDC) 2014 ( https://developer.apple.com/videos/play/wwdc2014-404/) provides a very convenient function for memoization that can be used with any pure function.

```
func memoize<T: Hashable, U>(fn: ((T) -> U, T) -> U) -> (T) -> U {
    var memo = Dictionary<T, U>()
    var result: ((T) -> U)!
    result = { x in
        if let q = memo[x] { return q }
        let r = fn(result, x)
        memo[x] = r
        return r
    }
    return result
}
```

```
let factorial = memoize { factorial, x in
    x == 0 ? 1 : x * factorial(x - 1)
}

print(factorial(5))
```

```
let powerOf2 = memoize { pow2, x in
    x == 0 ? 1 : 2 * pow2(x - 1)
}

print(powerOf2(5))
```

#### Value Type Characteristics
the structure of value types encourages testability, isolation, and interchangeability


#### switch wildcard pattern

```
let anOptionalString: String? = nil
// 1
switch anOptionalString {
    case _?: print ("Some")
    case nil: print ("None")
}
// 2
switch anOptionalString {
case let x?: print ("Some Value \(x)")
case nil: print ("None")
}
// 3
switch anOptionalString {
case .some(let x): print ("Some Value \(x)")
case .none: print ("None")
}
```

#### Type constraints

```
<T: Class> or <T: Protocol>
```

#### Subclassing generic classes

```
class Container<Item> {
}

// GenericContainer stays generic
class GenericContainer<Item>: Container<Item> {
}

// SpecificContainer becomes a container of Int type
class SpecificContainer: Container<Int> {
}
```


#### Apply
Apply is a function that applies a function to a list of arguments.

Swift does not provide any apply method on Arrays.

out apply
```
func apply<T, V>(fn: [T] -> V, args: [T]) -> V {
    return fn(args)
}
```

Example

```
let numbers = [1, 3, 5]

func incrementValues(a: [Int]) -> [Int] {
    return a.map { $0 + 1 }
}

let applied = apply(fn: incrementValues, args: numbers)
```


#### partitioning
```
typealias Accumlator = (lPartition: [Int], rPartition: [Int])

func partition(list: [Int], criteria: (Int) -> Bool) -> Accumlator {
    return list.reduce((lPartition: [Int](), rPartition: [Int]())) {
        (accumlator: Accumlator, pivot: Int) -> Accumlator in
        if criteria(pivot) {
            return (lPartition: accumlator.lPartition + [pivot],
              rPartition: accumlator.rPartition)
        } else {
            return (rPartition: accumlator.rPartition + [pivot],
              lPartition: accumlator.lPartition)
        }
    }
}

let numbersToPartition = [3, 4, 5, 6, 7, 8, 9]
partition(list: numbersToPartition) { $0 % 2 == 0 }
```

Generic one

```
func genericPartition<T>(list: [T],
                         criteria: (T) -> Bool) -> (lPartition: 
[T], 
                         rPartition: [T]) {
    return list.reduce((lPartition: [T](), rPartition: [T]())) {
        (accumlator: (lPartition: [T], rPartition: [T]), pivot: T) -> (
          lPartition: [T], rPartition: [T]) in
        if criteria(pivot) {
            return (lPartition: accumlator.lPartition + [pivot],
              rPartition: accumlator.rPartition)
        } else {
            return (rPartition: accumlator.rPartition + [pivot],
              lPartition: accumlator.lPartition)
        }
    }
}

let doublesToPartition = [3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0]
print(genericPartition(list: doublesToPartition) { $0.truncatingRemainder(dividingBy: 2.0) == 0 }
```
