# HelloSwift
[TOC]

## 1、Swift基本语法

### (1) 第一个HelloWorld程序

```swift
print("Hello, World!")
```

Swift程序的入口，可以没有main函数，而且每个语句可以没有分号。

官方文档描述[^1]，如下

> Code written at global scope is used as the entry point for the program, so you don’t need a `main()` function. You also don’t need to write semicolons at the end of every statement.



### (2) 定义变量

#### a. var和let

Swift中使用var和let定义变量

* 值会后续被修改，使用var
* 值是常量不会被修改，使用let

示例代码，如下

```swift
var myVariable = 42
myVariable = 50
let myConstant = 42
```



#### b. 变量类型

Swift中定义变量，可以不用写类型，编译器会推断变量的类型

示例代码，如下

```swift
let implicitInteger = 70
let implicitDouble = 70.0
let explicitDouble: Double = 70
```

* implicitInteger被隐式推断为Integer
* implicitDouble被隐式推断为Double
* explicitDouble显示定义为Double

注意

> 变量之间的类型转换，在Swift中是不支持隐式转换的。需要明确显式转换。举个例子，如下
>
> ```swift
> let label = "The width is "
> let width = 94
> let widthLabel = label + String(width)
> ```
>
> 这里width变量必须转成String类型，才能做字符串拼接



#### c. 可选变量

在变量类型后面，跟着一个`?`，表示这个变量是可能为nil的

举个例子，如下

```swift
var optionalString: String? = "Hello"
print(optionalString == nil)
```



当一个变量是对象，而且这个变量定义为可选。那么这个对象的属性，即使不是可选，获取的变量也是一个可选变量。

举个例子，如下

```swift
let optionalSquare: Square? = Square(sideLength: 2.5, name: "optional square")
let sideLength = optionalSquare?.sideLength
```

这里sideLength将是一个可选变量。即使sideLength属性在Square类中定义不是可选的。



### (3) 字符串

#### a. String interpolation

使用`\()`进行字符串插入变量值。举个例子，如下

```swift
let apples = 3
let oranges = 5
let appleSummary = "I have \(apples) apples."
let fruitSummary = "I have \(apples + oranges) pieces of fruit."
```

`\()`的括号，可以放入代码进行计算。



#### b. 多行字符串

使用三个引号`"""`，实现多行字符串。举个例子，如下

```swift
let quotation = """
I said "I have \(apples) apples."
And then I said "I have \(apples + oranges) pieces of fruit."
"""
```

说明

> 三个引号`"""`中，允许单个`"`





### (4) 容器类型(Array/Dictionary)

Array和Dictionary都可以使用`[]`来定义，访问每个元素，使用下标index或者key。

举个例子，如下

```swift
var shoppingList = ["catfish", "water", "tulips"]
shoppingList[1] = "bottle of water"

var occupations = [
    "Malcolm": "Captain",
    "Kaylee": "Mechanic",
]
occupations["Jayne"] = "Public Relations"
```

说明

> Array和Dictionary定义，允许最后一个元素跟着一个逗号



创建一个空的Array或者Dictionary，如下

```swift
let emptyArray: [String] = []
let emptyDictionary: [String: Float] = [:]
```

如果要赋值一个空的Array或者Dictionary，如下

```swift
shoppingList = []
occupations = [:]
```



### (5) 控制流(Control Flow)

 Swift支持的控制流语句，如下

* 条件语句
  * if
  * switch

* 循环语句
  * for-in
  * while
  * repeat-while

控制流语句的条件或者循环变量的括号是可以省略的。语句的body需要括号，这个不能省略。

举个例子，如下

```swift
let individualScores = [75, 43, 103, 87, 12]
var teamScore = 0
for score in individualScores {
    if score > 50 {
        teamScore += 3
    } else {
        teamScore += 1
    }
}
print(teamScore)
```

这里for语句和if语句都省略了括号

注意

> if语句的条件，必须是一个Boolean表达式。如果写成if score { ... }，则编译器会报错，编译器不支持隐式和0做比较。



#### a. if-let语句

if和let可以组成if-let语句，它完成2个事情：if语句中的局部变量赋值，和判断这个局部变量是否nil。

举个例子，如下

```swift
var optionalName: String? = "John Appleseed"
var greeting = "Hello!"
if let name = optionalName {
    greeting = "Hello, \(name)"
}
```

这里如果name为nil，则if语句不执行。



#### b. `??`操作符

和if-let语句的作用类似，`??`操作符为可选变量提供一个默认值。

举个例子，如下

```swift
let nickname: String? = nil
let fullName: String = "John Appleseed"
let informalGreeting = "Hi \(nickname ?? fullName)"
```

这里如果nickname不为nil，则`informalGreeting = "Hi \(nickname)"`；为nil，则`informalGreeting = "Hi \(fullName)"`



#### c. switch语句

Swift中switch语句支持更多case条件的比较，以及自定义case条件。

举个例子，如下

```swift
let vegetable = "red pepper"
switch vegetable {
case "celery":
    print("Add some raisins and make ants on a log.")
case "cucumber", "watercress":
    print("That would make a good tea sandwich.")
case let x where x.hasSuffix("pepper"):
    print("Is it a spicy \(x)?")
default:
    print("Everything tastes good in soup.")
}
// Prints "Is it a spicy red pepper?"
```

这里第三个case属于自定义case条件。

说明

> Swift中switch语句的case中不用使用break



#### d. for-in语句

for-in语句在对Dictionary遍历时，需要提供key-value形式的2个变量。举个例子，如下

```swift
let interestingNumbers = [
    "Prime": [2, 3, 5, 7, 11, 13],
    "Fibonacci": [1, 1, 2, 3, 5, 8],
    "Square": [1, 4, 9, 16, 25],
]
var largest = 0
for (_, numbers) in interestingNumbers {
    for number in numbers {
        if number > largest {
            largest = number
        }
    }
}
print(largest)
// Prints "25"
```

这里`_`符号起到站位的作用，代表interestingNumbers的每个key，而numbers代表interestingNumbers的每个value。



for-in语句，如果按照下标范围变量，则使用`..<`定义一个范围。举个例子，如下

```swift
var total = 0
for i in 0..<4 {
    total += i
}
print(total)
// Prints "6"
```

说明

> `..<`，创建一个左闭右开的区间，即[a, b)
>
> `...`，创建一个左闭右闭的区间，即[a, b]



#### e. while语句和repeat-while语句

举个例子，如下

```swift
var n = 2
while n < 100 {
    n *= 2
}
print(n)
// Prints "128"

var m = 2
repeat {
    m *= 2
} while m < 100
print(m)
// Prints "128"
```



### (6) 函数(Function)和闭包(Closure)

在Swift中使用`func`声明一个函数，如果函数有返回值，则使用`-> ReturnType`来声明返回值类型。

举个例子，如下

```swift
func greet(person: String, day: String) -> String {
    return "Hello \(person), today is \(day)."
}
greet(person: "Bob", day: "Tuesday")
```

定义函数的参数列表，默认把变量名做一个label。上面greet函数的参数有person和day这2个label。label的作用是调用函数时，方便代码自解释。

注意

> label也是函数符号的一部分。按照label传实参的顺序不能乱。比如greet(day: "Tuesday", person: "Bob")，则编译器会报错。



当然形参可以没有label，或者取另外一个名字。举个例子，如下

```swift
func greet(_ person: String, on day: String) -> String {
    return "Hello \(person), today is \(day)."
}
greet("John", on: "Wednesday")
```

说明

> ```swift
> func greet(person: String, day: String) -> String {
>     return "Hello \(person), today is \(day)."
> }
> 
> func greet(_ person: String, on day: String) -> String {
>     return "Hello \(person), today is \(day)."
> }
> ```
>
> 上面2个函数是不同的函数签名，分别是`greet(person:day:)`和`greet(_:on:)`，因此上面2个函数可以同时定义，编译器不会报错符号冲突。



#### a. 返回多个值

Swift中使用Tuple来返回多个值。举个例子，如下

```swift
func calculateStatistics(scores: [Int]) -> (min: Int, max: Int, sum: Int) {
    var min = scores[0]
    var max = scores[0]
    var sum = 0

    for score in scores {
        if score > max {
            max = score
        } else if score < min {
            min = score
        }
        sum += score
    }

    return (min, max, sum)
}
let statistics = calculateStatistics(scores: [5, 3, 100, 3, 9])
print(statistics.sum)
// Prints "120"
print(statistics.2)
// Prints "120"
```

上面拿到返回值赋值给statistics变量，通过名字或者序号都可以访问Tuple中的特定元素。



#### b. 函数嵌套

Swift中允许函数嵌套。

举个例子，如下

```swift
func returnFifteen() -> Int {
    var y = 10
    func add() {
        y += 5
    }
    add()
    return y
}
returnFifteen()
```

被嵌套的函数可以访问外部函数中的定义的变量。这里在add函数中使用returnFifteen函数定义的变量y。



#### c. 函数作为返回值

Swift中允许函数作为返回值。

举个例子，如下

```swift
func makeIncrementer() -> ((Int) -> Int) {
    func addOne(number: Int) -> Int {
        return 1 + number
    }
    return addOne
}
var increment = makeIncrementer()
increment(7)
```

函数作为返回值赋值给变量，这个变量类似Objective-C的block变量，可以使用这个变量来调用函数。



#### d. 函数作为参数

Swift中允许函数作为参数。

举个例子，如下

```swift
func hasAnyMatches(list: [Int], condition: (Int) -> Bool) -> Bool {
    for item in list {
        if condition(item) {
            return true
        }
    }
    return false
}
func lessThanTen(number: Int) -> Bool {
    return number < 10
}
var numbers = [20, 19, 7, 12]
hasAnyMatches(list: numbers, condition: lessThanTen)
```

这里condition是一个函数形参。类似接收一个block变量，hasAnyMatches函数内部会使用这个condition变量作为函数调用。



#### e. 闭包(Closure)

在Swift中闭包是没有函数名的代码块，使用`in`来分隔函数参数和函数体。

官方文档描述[^1]，如下

> You can write a closure without a name by surrounding code with braces (`{}`). Use `in` to separate the arguments and return type from the body.

举个例子，如下

```swift
numbers.map({ (number: Int) -> Int in
    let result = 3 * number
    return result
})
```

这里map函数接收一个闭包作为参数。

如果函数的闭包类型是明确的，则闭包可以去掉参数和返回语句。

举个例子，如下

```swift
let mappedNumbers = numbers.map({ number in 3 * number })
print(mappedNumbers)
// Prints "[60, 57, 21, 36]"
```

这里3 * number作为返回值，省去了返回语句。

注意

> 去掉返回语句的情况，仅是闭包只包含一个语句的情况下，那么这个语句则是返回语句。



如果闭包是函数唯一的参数，则调用这个函数传入闭包时，可以把括号去掉。

举个例子，如下

```swift
let sortedNumbers = numbers.sorted { $0 > $1 }
print(sortedNumbers)
// Prints "[20, 19, 12, 7]"
```



### (7) 对象(Object)和类(Class)

在Swift中使用`class`来定义一个类，类中的属性和函数，和变量、函数的定义，没有区别，除了这些变量和函数的上下文是一个类而已。

举个例子，如下

```swift
class Shape {
    var numberOfSides = 0
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}
```

和Objective-C不一样，Swift定义一个类，可以不用指定一个特殊的父类。



使用一对括号`()`来创建一个类的对象，使用`.`来访问对象的属性和函数。

举个例子，如下

```swift
var shape = Shape()
shape.numberOfSides = 7
var shapeDescription = shape.simpleDescription()
```



#### a. 类的初始化函数init

在Swift中类约定使用`init`命名来定义一个初始化函数。

举个例子，如下

```swift
class NamedShape {
    var numberOfSides: Int = 0
    var name: String

    init(name: String) {
        self.name = name
    }

    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}
```

说明

> 可以定义一个`deinit`函数，作用是析构函数



#### b. 定义子类

在Swift中也是使用`:`来继承一个父类。

举个例子，如下

```swift
class Square: NamedShape {
    var sideLength: Double

    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 4
    }

    func area() -> Double {
        return sideLength * sideLength
    }

    override func simpleDescription() -> String {
        return "A square with sides of length \(sideLength)."
    }
}
let test = Square(sideLength: 5.2, name: "my test square")
test.area()
test.simpleDescription()
```

如果子类要重写父类的函数，则子类需要使用`orverride`来标记下这个函数。



#### c. 属性的setter和getter

Swift类的属性，也可以用setter和getter。

举个例子，如下

```swift
class EquilateralTriangle: NamedShape {
    var sideLength: Double = 0.0

    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 3
    }

    var perimeter: Double {
        get {
            return 3.0 * sideLength
        }
        set {
            sideLength = newValue / 3.0
        }
    }

    override func simpleDescription() -> String {
        return "An equilateral triangle with sides of length \(sideLength)."
    }
}
var triangle = EquilateralTriangle(sideLength: 3.1, name: "a triangle")
print(triangle.perimeter)
// Prints "9.3"
triangle.perimeter = 9.9
print(triangle.sideLength)
// Prints "3.3000000000000003"
```

在init函数中使用super调用父类的init函数，使用self来设置本类的属性。



#### d. willSet和didSet

TODO:https://docs.swift.org/swift-book/GuidedTour/GuidedTour.html



### (8) 枚举和结构体

在Swift中使用`enum`定义枚举类型，和其他有名字的类型(类等)，枚举定义中可以定义函数。

举个例子，如下

```swift
enum Rank: Int {
    case ace = 1
    case two, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king

    func simpleDescription() -> String {
        switch self {
        case .ace:
            return "ace"
        case .jack:
            return "jack"
        case .queen:
            return "queen"
        case .king:
            return "king"
        default:
            return String(self.rawValue)
        }
    }
}
let ace = Rank.ace
let aceRawValue = ace.rawValue
```

枚举默认从0开始定义枚举值，并且递增加1。可以显示赋值枚举值的rawValue，但是rawValue不是必须的。



#### a. 可选的init函数

通过`init?(rawValue:)`来初始化一个枚举变量。

举个例子，如下

```swift
if let convertedRank = Rank(rawValue: 3) {
    let threeDescription = convertedRank.simpleDescription()
}
```

如果枚举定义时，没有对应的rawValue，则初始化函数返回nil。



#### b. 定义枚举值的associated value

Swift的枚举值，可以在运行时附带一些数据(associated value)。

举个例子，如下

```swift
enum ServerResponse {
    case result(String, String)
    case failure(String)
}

let success = ServerResponse.result("6:00 am", "8:09 pm")
let failure = ServerResponse.failure("Out of cheese.")

switch success {
case let .result(sunrise, sunset):
    print("Sunrise is at \(sunrise) and sunset is at \(sunset).")
case let .failure(message):
    print("Failure...  \(message)")
}
// Prints "Sunrise is at 6:00 am and sunset is at 8:09 pm."
```

这里result和failure枚举值都有附带的数据，在初始化这2个枚举值，需要传入对应的参数值。

注意

> case result(String, String)这种形式，不能再设置rawValue。编译器会对case result(String, String) = 1进行报错。



#### c. 结构体

在Swift中结构体用`struct`定义，结构体和类基本是一样的，除了变量赋值，结构体对象是按值赋值，而类对象是按引用赋值的。

官方文档描述，如下

> Structures support many of the same behaviors as classes, including methods and initializers. One of the most important differences between structures and classes is that structures are always copied when they’re passed around in your code, but classes are passed by reference.

举个例子，如下

```swift
struct Card {
    var rank: Rank
    var suit: Suit
    func simpleDescription() -> String {
        return "The \(rank.simpleDescription()) of \(suit.simpleDescription())"
    }
}
let threeOfSpades = Card(rank: .three, suit: .spades)
let threeOfSpadesDescription = threeOfSpades.simpleDescription()
```



### (9) 协议(Protocol)和扩展(Extension)









## References

[^1]: https://docs.swift.org/swift-book/GuidedTour/GuidedTour.html
