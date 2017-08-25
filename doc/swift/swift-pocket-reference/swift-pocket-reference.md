# Swift Pocket Reference, 3rd Edition

#### import

```

//import ModuleName
import Cocoa

//import ModuleName.SubmoduleName
import Foundation.NSDate

//import Feature ModuleName.SymbolName
import func Darwin.sqrt

```

#### typealias

To create protocol compositions
```
typealias CC = Collection & Comparable
```

#### Determining Types

```
type(of: 4 < 5)
// returns Bool.Type
print type(of: "Hello")
// outputs String.Type

```


#### escape keyword

```
var func = 4         // not allowed – func is reserved
var `func` = 4       // allowed
```

#### Comparison operators

```
1. == A == B  Tess equality (same value)
2. === A=== B  Test identicality (same objects)

```

#### overflow

If you need to know whether an overflow actually occurred, the integer types implement function equivalents of these operators that return a tuple containing the result and a Boolean value indicating overflow state. 

- addWithOverflow()
- subtractWithOverflow()
- multiplyWithOverflow()
- divideWithOverflow()
- remainderWithOverflow()

```
Int.addWithOverflow(Int, Int) -> (Int, Bool)
let (result, ovf) = Int.addWithOverflow(someInt, someInt)
```

#### String

```
let hexStrFromInt = String(45, radix: 16, uppercase: true)
// "2D"
let strFromTuple = String(describing: (1, 2, 3))
// strFromTuple is now "(1, 2, 3)"
let strFromArray = String(describing: [1, 6, 91])
// strFromArray is now "[1, 6, 91]"

let array = [1, 6, 91]
print("\(array)")
// "[1, 6, 91]\n"
```


#### String from C-style

```
let sString = String(cString: ptr)
```

#### Character-Level Access

- The characters view of a string provides access to each component of the string as an extended grapheme cluster (or Character type). In our example string, that is the single character ä.

- The utf8 view provides access to each component of the string as a UTF-8 code unit. In this view, commonly used Roman characters are represented by a single byte, whereas multibyte sequences are used to represent combining characters and characters from non-Roman alphabets. In our example string, the character a would be represented by the 8-bit value 0x61, and the umlaut would be represented by the 8-bit value 0xCC followed by the 8-bit value 0x88.

- The utf16 view provides access to each component of the string as a UTF-16 code unit. In this view, commonly used Roman characters are represented by a double-byte (16-bit) value. Combining characters and characters from non-Roman alphabets can be represented by a single 16-bit value, rather than multibyte values. In our example string, the character a would be represented by the 16-bit value 0x0061, and the umlaut would be represented by the 16-bit value 0x0308.

- The unicodeScalars view provides access to each component of the string as a Unicode scalar value. In this view, combining characters are presented as separate components, and are not combined with the preceding character. In our example string, the scalars would consist of the character a represented by the 16-bit value 0x0061, and the umlaut represented by the 16-bit value 0x0308.

```
let aWithUmlaut: Character = "a\u{308}"

uString.characters.count      // 1 (ä)
uString.utf8.count            // 3 (0x61, 0xCC, 0x08)
uString.utf16.count           // 2 (0x0061, 0x0308)
uString.unicodeScalars.count  // 2 (0x0061, 0x0308)

```

#### String protocols
```
public protocol StringProtocol
  : BidirectionalCollection,
  TextOutputStream, TextOutputStreamable,
  LosslessStringConvertible, ExpressibleByStringLiteral,
  Hashable, Comparable
```

#### Option Set

```
struct TextStyle: OptionSet {
    let rawValue: UInt8

    static let bold      = TextStyle(rawValue: 1)
    static let italic    = TextStyle(rawValue: 2)
    static let underline = TextStyle(rawValue: 4)
    static let outline   = TextStyle(rawValue: 8)
}

```

#### Variadic Parameters

```
func someFunc(param: Type...) -> returnType { ... }
```

#### Closure syntax

```
{
     (parameters) -> returnType in
        statements
}
```

#### Capturing Values by Reference
In the preceding discussion, the value captured (the greeting string value) is actually copied when the closure is constructed, because that value is never modified by the closure.

Values that a closure modifies are not copied but are instead captured by reference.

```

func makeCountingTranslator(greeting: String,
    _ personNo: String) -> (String) -> String {
    var count = 0

    return {
      (name: String) -> String in
        count += 1
        return (
            "\(greeting) \(name), \(personNo) \(count)")
    }
}

var germanReception = makeCountingTranslator("Guten Tag", "Sie sind Nummer")
var aussieReception = makeCountingTranslator("G'day", "you're number")
    
germanReception ("Johan")
// returns "Guten Tag Johan, Sie sind Nummer 1"
aussieReception ("Bruce")
// returns "G'day Bruce, you're number 1"
aussieReception ("Kylie")
// returns "G'day Kylie, you're number 2"

```

Each closure stores a reference to count, which is a local variable in the makeCountingTranslator() function. In doing so, they extend the lifetime of that local variable to the lifetime of the closure.

#### for loop and case

```
let processors: [(name: String, buswidth: Int)] = [
    ("Z80", 8),
    ("16032", 16),
    ("80286", 16),
    ("6502", 8)
]
for case let (name, 8) in processors {
    print ("the", name, "has a bus width of 8 bits")
}
// outputs
// the Z80 has a bus width of 8 bits
// the 6502 has a bus width of 8 bits

```

#### available
```
if #available(macOS 10.10, *) {
    // use macOS 10.10 feature
} else {
    // use macOS 10.9 feature
}

```

```
@available(iOS 9, *) func ios9Func() {
    // functionality for iOS 9 feature
}
```

#### switch and where
```
switch record {
    // ... preceding cases
    case (_, 7, let day) where day.hasPrefix("T"):
        print ("Home Economics")
    // subsequent cases...
}
```

#### label

```
outerloop: for i in 1..< 10 {
    for j in 1..< 10 {
        if ((i == 6) && ((i * j) >= 30)) 
            { continue outerloop }
        print (i * j)
    }
    print ("-")
}
```

#### getter
```
class BetterEmployee
{
    private static var _nextID = 1
    class var nextID: Int {
        get { 
            defer { _nextID += 1 }
            return _nextID }
        set {
            _nextID = newValue
        }
    }
    var familyName = ""
    var givenName = ""
    var employeeID = 0
}
```

```
let be = BetterEmployee()
be.employeeID = BetterEmployee.nextID
```

#### Subscripts
```
class Byte
{
    var rawVal: UInt8 = 0

    subscript(whichBit: UInt8) -> UInt8 {
        get { return (rawVal >> whichBit) & 1 }
        set {
            let mask = 0xFF ^ (1 << whichBit)
            let bit = newValue << whichBit
            rawVal = rawVal & mask | bit
        }
    }
}
```

```
let b = Byte()
b[0] = 1
// b is now 0000 0001, or 1
b[2] = 1
// b is now 0000 0101, or 5
b[0] = 0
// b is now 0000 0100, or 4
```

#### Recursive Enumerations

```
indirect enum List {
    case empty
    case subList(head: Int, tail: List)
}

let list1 = List.subList(value: 4, tail: List.empty)
let list2 = List.subList(value: 1, tail: list1)
let list3 = List.subList(value: 2, tail: list2)
print (list3)
// will output:
// subList(2, List.subList(1, List.subList(4, List.empty)))
```

#### Access control

Open entities are accessible from any source file in the module in which they are defined as well as any source file that imports that module. This is the least restrictive access level, and is only applicable to classes and their members. It is intended for use in frameworks that are designed to be subclassed.

Public entities are accessible from any source file in the module in which they are defined as well as any source file that imports that module. Public classes can’t be subclassed outside of the module in which they’re defined.

#### extension

```
extension Int
{
    var asHex: String {
        var temp = self
        var result = ""
        let digits = Array("0123456789abcdef".characters)
        while temp > 0 {
            result = String(digits[Int(temp & 0x0f)]) 
                        + result
            temp >>= 4
        }
        return result
    }
}
```

```
extension UInt8
{
    subscript(whichBit: UInt8) -> UInt8 {
        get { return (self >> whichBit) & 1 }
        set {
            let mask = 0xFF ^ (1 << whichBit)
            let bit = (newValue & 1) << whichBit
            self = self & mask | bit
        }
    }
}

var b: UInt8 = 0
b[0] = 1
b[7] = 1
b
// returns 129
```

#### type

```
for s in shapes
{
    if let c = s as? Circle {
        // c is now a reference to an array entry downcast
        // as a circle instead of as a generic shape
    } else {
        // downcast failed
    }
}
```

```
for s in shapes
{
    switch s {
        case let cc as Circle:
            cc.identify()
        case let ss as Square:
            ss.describe()
        default:
            break;
    }
}
```

#### Any Object

|Type|Can represent any... |
|---|---|
|Any|instance of any type|
|AnyBidirectionalCollection|type that conforms to the BidirectionalCollection protocol|
|AnyClass|class type|
|AnyCollection|type that conforms to the Collection protocol|
|AnyHashable|type that conforms to the Hashable protocol|
|AnyIndex|type that conforms to the Indexable protocol|
|AnyIterator|type that conforms to the Iterator protocol|
|AnyObject|instance of any class|
|AnyRandomAccessCollection|type that conforms to the RandomAccessCollection protocol|
|AnySequence|type that conforms to the Sequence protocol|


#### built-in protocols

#### Built-in Protocols
- ExpressibleByArrayLiteral
- ExpressibleByBooleanLiteral
- ExpressibleByDictionaryLiteral
- ExpressibleByExtendedGraphemeClusterLiteral
- ExpressibleByFloatLiteral
- ExpressibleByIntegerLiteral
- ExpressibleByNilLiteral
- ExpressibleByStringInterpolation
- ExpressibleByStringLiteral
- ExpressibleByUnicodeScalarLiteral


- AbsoluteValuable
- Any
- AnyClass
- AnyObject
- BidirectionalCollection		//	index(before:)
- BinaryFloatingPoint		// A floating-point type that follows IEEE 754 encoding conventions, and which acts as a base for the Double, Float, and Float80 types.
- BitwiseOperations
- Collection
- Comparable
- CustomDebugStringConvertible
- CustomLeafReflectable  // Used to build a custom mirror of an instance (like CustomReflectable). Descendant classes are not represented in the mirror unless they override cus⁠tom​Mir⁠ror().
- CustomPlaygroundQuickLookable
- CustomReflectable
- CustomStringConvertable
- CVarArg
- Equatable
- Error
- FloatingPoint
- Hashable
- Integer
- IntegerArithmetic
- IteratorProtocol	//	next()
- LazyCollection	// A collection on which methods (like map and filter) are implemented lazily. They compute elements on demand using the underlying storage, rather than all at once and by creating a mutated copy of the original collection.
- LazySequence
- MutableCollection
- OptionSet
- RandomAccessCollection
- RangeReplaceableCollection
- RawRepresentable
- Sequence //	makeIterator()
- SetAlgebra
- SignedInteger
- SignedNumber
- Strideable
- TextOutputStream	// print()
- TextOutputStreamable
- UnicodeCodec
- UnsignedInteger

#### Memory Layout

Swift 3 features the generic enumeration MemoryLayout with associated type properties and type methods for determining the size and alignment of objects in memory.

```
MemoryLayout<T>.alignment
The alignment of type T, as an Int.
MemoryLayout<T>.size
The contiguous memory footprint of T, as an Int.
MemoryLayout<T>.stride
The number of bytes from one instance of T to the next in an array of T, as an Int.
The same properties for instances can be determined using the following functions:

MemoryLayout.alignment(ofValue: v)
The alignment of value v, as an Int.
MemoryLayout.size(ofValue: v)
The contiguous memory footprint of v, as an Int.
MemoryLayout.stride(ofValue: v)
The number of bytes from one instance of v to the next in an array of v, as an Int.
```

Note that the size and stride values do not include dynamically allocated storage associated with a type, such as storage allocated to a string.

#### Generic Constraining Types

```
<T: SomeClass>
<T: SomeProtocol>

struct SignedQueue<T: SignedInteger> {
    // existing definition
}

```

#### Generic Protocols

To use an associated type, the protocol definition takes this form:

```
protocol SomeProtocol
{
    associatedtype SomeName
    // remainder of protocol definition with the generic
    // type references expressed as SomeName
}

#### Custom Operators

```
[prefix|postfix|infix] operator operator


prefix operator √
prefix func √ (operand: Double) -> Double {
    return sqrt(operand)
}
print (√25)
// outputs 5.0

#### Ranges
Range and ClosedRange

someRange.clamped(to: someOtherRange)
someRange.contains(someValue)
someRange.lowerBound
someRange.upperBound
~=

You can check if a value is within a range with the ~= pattern match operator, for example:
```
// assuming f is a Double
if 2.0...6.0 ~= f { 
    ... 
}
```

#### Declaration Attributes
```
@discardableResult
func parseInputFile() -> Bool
```

```
@available(options, *)
@discardableResult
@GKInspectable
@IBAction
@IBDesignable
@IBInspectable
@IBOutlet
@nonobjc
@NSApplicationMain
@NSCopying
@NSManaged
@objc(name)
@testable
@UIApplicationMain
```

```
@available(OSX 10.6, iOS 4.0, *)
@available(*, deprecated, renamed: "fileWriteVolumeReadOnly")
public static var fileWriteVolumeReadOnlyError: 
​    CocoaError.Code { get }
```

#### Global (Free) Functions

```
abs(x)
assert(condition: Bool [, message: String])
assertionFailure([message: String])
debugPrint(items... [, separator: String]
[, terminator: String], to: &stream)
dump(x)
fatalError([message: String])
getVAList(args: CVarArgType)
isKnownUniquelyReferenced(&someObject)
// Returns a Bool value of true if it is known that there is a single strong reference to someObject. someObject is not modified, despite the inout annotation. Useful for implementing copy-on-write optimization of value types.

max(list)
min(list)
numericCast(x)
precondition(condition: Bool[, message: String])
preconditionFailure([message: String])
print(items... [, separator: String]
[, terminator: String] [, to: &stream])
readLine([stripNewLine: Bool])
repeatElement(T, count: Int)
stride(from: start, through: end, by: step)
stride(from: start, to: end, by: step)
swap(&x, &y)
transcode(input: Input, from: InputEncoding.Type,
to: outputEncoding.Type, stoppingOnError: Bool, 
into: Output)
unsafeBitCast(x, to: t)
unsafeDowncast(x, to: Type)
withExtendedLifetime(x, f)
withUnsafeMutablePointer(to: &x, f)
withUnsafePointer(to: &x, f)
withVaList(args: [CVarArgType], f)
zip(Sequence1, Sequence2)

```