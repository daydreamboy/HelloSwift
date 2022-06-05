# ArgumentParser

[TOC]

## 1、介绍ArgumentParser

ArgumentParser是一个Swift库，Git地址是https://github.com/apple/swift-argument-parser。它用于解析命令行字符串，类似Ruby的optparse库，和Python的argparse库。

Swift官方文档地址是https://www.swift.org/blog/argument-parser/



## 2、关于Property Wrapper

在使用ArgumentParser之前，先介绍Property Wrapper，因为使用ArgumentParser，实际上是通过Property Wrapper来使用ArgumentParser库

关于Property Wrapper，官方地址是https://docs.swift.org/swift-book/LanguageGuide/Properties.html#ID617。

这里参考这篇文章[^1]来介绍Property Wrapper。

知道Objective-C语法，应该清楚属性都有对应的setter方法和getter方法。那Property Wrapper是基于属性定义了一层逻辑用于访问这个属性，比如在调用属性getter方法之前执行某个计算逻辑等。

官方文档对Property Wrapper的定义[^2]，如下

> A property wrapper adds a layer of separation between code that manages how a property is stored and the code that defines a property



### (1) 创建一个Property Wrapper

定义Property Wrapper，使用关键词`@propertyWrapper`标记一个struct定义。

举个例子，如下

```swift
@propertyWrapper
struct UserDefault<Value> {
    let key: String
    let defaultValue: Value
    var container: UserDefaults = .standard

    var wrappedValue: Value {
        get {
            return container.object(forKey: key) as? Value ?? defaultValue
        }
        set {
            container.set(newValue, forKey: key)
        }
    }
}
```

每个Property Wrapper都默认有一个wrappedValue属性，和projectedValue属性（可选的）。

上面例子中，wrappedValue属性的set方法和get方法，实际上是通过UserDefaults对象来做读写操作。而且UserDefault定义key、defaultValue和container属性。

使用Property Wrapper，通过`@PropertyWrapperName`来修饰属性。

举个例子，如下

```swift
extension UserDefaults {

    @UserDefault(key: "has_seen_app_introduction", defaultValue: false)
    static var hasSeenAppIntroduction: Bool
}
```

这里UserDefault有2个初始化方法，如下

```swift
@UserDefault(key: <#T##String#>, defaultValue: <#T##_#>, container: <#T##UserDefaults#>)
@UserDefault(key: <#T##String#>, defaultValue: <#T##_#>)
```

因为container已经初始化过，所以它是可选参数。

最后通过设置UserDefaults.hasSeenAppIntroduction完成UserDefault的持久化。

```swift
UserDefaults.hasSeenAppIntroduction = false
print(UserDefaults.hasSeenAppIntroduction) // Prints: false
UserDefaults.hasSeenAppIntroduction = true
print(UserDefaults.hasSeenAppIntroduction) // Prints: true
```

当读hasSeenAppIntroduction属性时，会执行UserDefault的wrappedValue属性的get方法。

当写hasSeenAppIntroduction属性时，会执行UserDefault的wrappedValue属性的set方法。

> 示例代码，见Test_property_wrapper_basic.swift



这里梳理下，Property Wrapper和Property的关系：

**每个Property可以被一个Property Wrapper修饰，形成一对一关系。`@PropertyWrapperName`实际上初始化一个Property Wrapper对象，然后Property的访问都会通过Property Wrapper对象的wrappedValue属性，即它的get方法和set方法。**



如果要设置container参数，则可以向下面这样创建一个UserDefaults对象来设置container参数

```swift
extension UserDefaults {
    static let groupUserDefaults = UserDefaults(suiteName: "group.com.swiftlee.app")!

    @UserDefault(key: "has_seen_app_introduction", defaultValue: false, container: .groupUserDefaults)
    static var hasSeenAppIntroduction: Bool
}
```



### (2) 复用Property Wrapper

上面介绍了如何创建一个Property Wrapper。很明显，Property Wrapper的复用能力很强，举个例子，如下

```swift
extension UserDefaults {

    @UserDefault(key: "has_seen_app_introduction", defaultValue: false)
    static var hasSeenAppIntroduction: Bool

    @UserDefault(key: "username", defaultValue: "Antoine van der Lee")
    static var username: String

    @UserDefault(key: "year_of_birth", defaultValue: 1990)
    static var yearOfBirth: Int
}
```

上面@UserDefault修饰了3个属性，而UserDefault的set方法和get方法只需要一份。



### (3) 自定义Property Wrapper的初始化函数

上面可以看出定义Property Wrapper的属性时，默认有初始化函数。如果要自定义这个初始化函数，则可以通过extension来定义自己的函数。举个例子，如下

```swift
extension UserDefault where Value: ExpressibleByNilLiteral {
    
    /// Creates a new User Defaults property wrapper for the given key.
    /// - Parameters:
    ///   - key: The key to use with the user defaults store.
    init(key: String, _ container: UserDefaults = .standard) {
        self.init(key: key, defaultValue: nil, container: container)
    }
}
```

使用这个初始化函数，如下

```swift
extension UserDefaults {

    @UserDefault(key: "year_of_birth")
    static var yearOfBirth: Int?
}
```



### (4) 使用projectedValue属性

Property Wrapper提供projectedValue属性。在Property Wrapper修饰的属性名，增加$前缀，就可以访问到projectedValue属性。

官方文档描述[^2]，如下

> The name of the projected value is the same as the wrapped value, except it begins with a dollar sign (`$`). Because your code can’t define properties that start with `$` the projected value never interferes with properties you define.

举个例子，如下

```swift
@propertyWrapper
struct UserDefault<Value> {
    let key: String
    let defaultValue: Value
    var container: UserDefaults = .standard
    private let publisher = PassthroughSubject<Value, Never>()
    
    var wrappedValue: Value {
        get {
            return container.object(forKey: key) as? Value ?? defaultValue
        }
        set {
            // Check whether we're dealing with an optional and remove the object if the new value is nil.
            if let optional = newValue as? AnyOptional, optional.isNil {
                container.removeObject(forKey: key)
            } else {
                container.set(newValue, forKey: key)
            }
            publisher.send(newValue)
        }
    }

    var projectedValue: AnyPublisher<Value, Never> {
        return publisher.eraseToAnyPublisher()
    }
}

extension UserDefaults {
    @UserDefault(key: "username", defaultValue: "Antoine van der Lee")
    static var username: String
}
```

使用projectedValue属性，如下

```swift
func test_use_projected_value() throws {
    _ = UserDefaults.$username.sink { username in
        print("New username: \(username)")
    }
    UserDefaults.username = "Test"
    // Prints: New username: Test
}
```

这里$username返回一个AnyPublisher对象，但是实际它是PassthroughSubject对象，对应的是publisher变量。这里使用eraseToAnyPublisher方法，将PassthroughSubject对象转成了AnyPublisher对象。



另外，projectedValue属性也是可写的。

举个官方的例子[^2]，如下

```swift
@propertyWrapper
struct SmallNumber {
    private var number: Int
    private(set) var projectedValue: Bool

    var wrappedValue: Int {
        get { return number }
        set {
            if newValue > 12 {
                number = 12
                projectedValue = true
            } else {
                number = newValue
                projectedValue = false
            }
        }
    }

    init() {
        self.number = 0
        self.projectedValue = false
    }
}
struct SomeStructure {
    @SmallNumber var someNumber: Int
}
var someStructure = SomeStructure()

someStructure.someNumber = 4
print(someStructure.$someNumber)
// Prints "false"

someStructure.someNumber = 55
print(someStructure.$someNumber)
// Prints "true"
```



### (5) 访问Property Wrapper的属性

上面提供每个Property会对应一个Property Wrapper对象，实际上Property对象，可以使用`.`直接来访问Property Wrapper的属性。

举个例子，如下

```swift
@propertyWrapper
struct UserDefault<Value> {
    let key: String
    let defaultValue: Value
    var container: UserDefaults = .standard

    var wrappedValue: Value {
        get {
            return container.object(forKey: key) as? Value ?? defaultValue
        }
        set {
            container.set(newValue, forKey: key)
        }
    }

    var projectedValue: UserDefault<Value> {
        self
    }
}

extension UserDefaults {
    @UserDefault(key: "has_seen_app_introduction", defaultValue: false)
    static var hasSeenAppIntroduction: Bool
}

extension UserDefaults {
    static func printPrivateProperties() {
        // Through projected value
        print($hasSeenAppIntroduction.key)
    }
}
```

这里使用projectedValue属性返回self，它是一个`UserDefault<Value>`类型，因此可以使用`.`访问到对应的属性。



除了结合projectedValue属性返回self的这种方式，在同一个作用域内，可以直接使用`_`方式来访问非私有属性。

举个例子，如下

```swift
extension UserDefaults {
    static func printPrivateProperties() {
        // Through underscore
        print(_hasSeenAppIntroduction.key)
    }
}
```



### (6) 在static subscript中访问Property Wrapper对象

在static subscript中，也可以访问到Property Wrapper对象。

举个例子，如下

```swift
@propertyWrapper
struct UserDefault<Value> {
    let key: String
    let defaultValue: Value

    @available(*, unavailable)
    var wrappedValue: Value {
        get { fatalError("This wrapper only works on instance properties of classes") }
        set { fatalError("This wrapper only works on instance properties of classes") }
    }

    static subscript(
        _enclosingInstance instance: Preferences,
        wrapped wrappedKeyPath: ReferenceWritableKeyPath<Preferences, Value>,
        storage storageKeyPath: ReferenceWritableKeyPath<Preferences, Self>
    ) -> Value {
        get {
            let propertyWrapper = instance[keyPath: storageKeyPath]
            let key = propertyWrapper.key
            let defaultValue = propertyWrapper.defaultValue
            return instance.container.object(forKey: key) as? Value ?? defaultValue
        }
        set {
            let propertyWrapper = instance[keyPath: storageKeyPath]
            let key = propertyWrapper.key
            instance.container.set(newValue, forKey: key)
        }
    }
}

final class Preferences {
    let container = UserDefaults(suiteName: "group.com.swiftlee.app")!

    @UserDefault(key: "has_seen_app_introduction", defaultValue: false)
    var hasSeenAppIntroduction: Bool
}
```



### (7) 使用Property Wrapper到函数参数和闭包参数

除了将Property Wrapper修饰到属性上，还可以修改到函数参数和闭包参数上。

说明

> 修饰在闭包参数上，Prop1erty Wrapper还在存在bug[^1]。这里不做介绍。

举个例子，如下

```swift
@propertyWrapper
struct Debuggable<Value> {
    private var value: Value
    private let description: String

    init(wrappedValue: Value, description: String = "") {
        print("Initialized '\(description)' with value \(wrappedValue)")
        self.value = wrappedValue
        self.description = description
    }

    var wrappedValue: Value {
        get {
            print("Accessing '\(description)', returning: \(value)")
            return value
        }
        set {
            print("Updating '\(description)', newValue: \(newValue)")
            value = newValue
        }
    }
}

class Test_property_wrapper_attach_to_function: XCTestCase {
    func runAnimation(@Debuggable(description: "Duration") withDuration duration: Double) {
        UIView.animate(withDuration: duration) {
            // ..
        }
    }

    func test_property_wrapper_attach_to_function() throws {
        runAnimation(withDuration: 2.0)
    }
}
```

当执行到UIView.animate(withDuration: duration)这一行，会触发wrappedValue的get方法。而runAnimation(withDuration: 2.0)会触发init方法。



## 3、ArgumentParser的Property Wrapper

上面基本详细介绍了Property Wrapper的实现，ArgumentParser也是实现了自己的Property Wrapper，来完成命令行字符串解析。ArgumentParser提供了下面几个Property Wrapper[^3]，如下

* @Argument，用于解析固定参数
* @Option，用于解析选项参数，通常是键值对形式。例如--src=file.csv
* @Flag，用于解析flag参数，即开关参数或者枚举参数。例如ls -l

除了上面几个Property Wrapper，ArgumentParser还提供ParsableCommand协议，而这个协议继承自ParsableArguments协议。

ParsableCommand定义，如下

```swift
public protocol ParsableCommand: ParsableArguments {
  /// Configuration for this command, including subcommands and custom help
  /// text.
  static var configuration: CommandConfiguration { get }
  
  /// *For internal use only:* The name for the command on the command line.
  ///
  /// This is generated from the configuration, if given, or from the type
  /// name if not. This is a customization point so that a WrappedParsable
  /// can pass through the wrapped type's name.
  static var _commandName: String { get }
  
  /// The behavior or functionality of this command.
  ///
  /// Implement this method in your `ParsableCommand`-conforming type with the
  /// functionality that this command represents.
  ///
  /// This method has a default implementation that prints the help screen for
  /// this command.
  mutating func run() throws
}
```

可见实现ParsableCommand协议，需要实现run函数和configuration变量（可选的）

如果要运行命令，则调用实现类的main函数

举个例子，如下

```swift
CharacterCount.main()
```



### (1) 使用@Argument

#### a. 解析可选固定参数

@Argument用于定义固定参数，可以定义多个属性以及可选属性，则命令行中接收多个参数[^4]。

举个例子，如下

```swift
import ArgumentParser

struct CharacterCount : ParsableCommand {
    // Input:
    // Alice
    // Alice Bob
    
    @Argument(help: "String to count the characters of") var string: String
    // Note: use optional variable to mark the argument is optional
    @Argument(help: "A second string to count the characters of") var string2: String?
    
    func run() throws {
        print(string.count)
        
        if let str2 = string2 {
            print(str2.count)
        }
    }
}
```

这里string2是可选变量，因此它对应的固定参数也是可选的。



#### b. 接收固定参数数组

举个例子，如下

```swift
struct CharacterCount2 : ParsableCommand {
    // Input:
    // $ ./character-count2 "Alice Bob"
    @Argument(help: "Strings to count the characters of") var strings: [String]
    
    func run() throws {
        strings.forEach { print($0.count) }
    }
}
```

如果固定参数很多，则使用数组变量，会方便很多。



#### c. 转换固定参数

如果参数在接收后，需要额外处理，则可以定义transform参数。举个例子，如下

```swift
struct CharacterCount4 : ParsableCommand {
    // Input:
    // $ ./character-count4 Alice
    @Argument(help: "String to count the characters of", transform: ({ return "\($0)makeItLonger" })) var string: String
    
    func run() throws {
        print(string)
        print(string.count)
    }
}
```

这里transform参数是一个闭包，将字符串添加makeItLonger后缀。

再举一个例子，如下

```swift
struct CharacterCount5 : ParsableCommand {
    // Input:
    // $ ./character-count5 https://www.baidu.com/
    @Argument(help: "URL to retrieve", transform: ({ return URL(string: $0)!})) var string: URL
    
    func run() throws {
        print(string)
    }
}
```



### (2) 使用@Option

@Option用法和@Argument类似，举个例子[^4]，如下

```swift
struct CharacterCount6 : ParsableCommand {
    // Input:
    // $ ./character-count3 Alice --multiplier 4
    @Argument(help: "String to count the characters of") var string: String
    // Note: use @Option to receive the option
    @Option(help: "The number to multiply the count against.") var multiplier: Int
    
    func run() throws {
        print(string.count * multiplier)
    }
}
```



#### a. Option的长短名

通过设置name参数，可以配置选项参数的长短名规则。

举个例子，如下

```swift
struct CharacterCount7 : ParsableCommand {
    // Input:
    // $ ./character-count3 Alice -m 3
    
    // Wrong Input:
    // Alice --multiplier 4
    @Argument(help: "String to count the characters of") var string: String
    // Note: use @Option to receive the option
    @Option(name: .short, help: "The number to multiply the count against.") var multiplier: Int
    
    func run() throws {
        print(string.count * multiplier)
    }
}
```

这里设置为短名称，使用-m，则不能使用--multiplier



举个自定义名字的例子，如下

```swift
struct CharacterCount9 : ParsableCommand {
    // Input:
    // $ ./character-count3 Alice -m 3
    
    @Argument(help: "String to count the characters of") var string: String
    // Note: use @Option to receive the option
    @Option(name: .customLong("multi"), help: "The number to multiply the count against.") var multiplier: Int
    
    func run() throws {
        print(string.count * multiplier)
    }
}
```

另外name参数可以接收数组值，举个例子，如下

```swift
struct CharacterCount11 : ParsableCommand {
    // Input:
    // $ ./character-count3 Alice -m 3
    
    @Argument(help: "String to count the characters of") var string: String
    // Note: use @Option to receive the option
    @Option(name: [.customShort("w"), .customLong("multi")], help: "The number to multiply the count against.") var multiplier: Int
    
    func run() throws {
        print(string.count * multiplier)
    }
}
```

如果是多个自定义的名称，也是可以的，举个例子，如下

```swift
struct CharacterCount12 : ParsableCommand {
    // Input:
    // $ ./character-count3 Alice -m 3
    
    @Argument(help: "String to count the characters of") var string: String
    // Note: use @Option to receive the option
    @Option(
        name: [
        .customLong("multiplier"),
        .customLong("multi"),
        .customLong("mult"),
        .customLong("multiplicador"),
        .customLong("multiplierr")],
      help: "The number to multiply the count against.") var multiplier: Int
    
    func run() throws {
        print(string.count * multiplier)
    }
}
```



#### b. Option的默认值

Option可以设置默认值，即直接给变量初始化就可以了。举个例子，如下

```swift
struct CharacterCount13 : ParsableCommand {
    // Input:
    // $ ./character-count3 Alice -m 3
    
    @Argument(help: "String to count the characters of") var string: String
    @Option(help: "The number to multiply the count against.") var multiplier: Int = 1
    
    func run() throws {
        print(string.count * multiplier)
    }
}
```



#### c. Option的转换

Option也有transform参数，举个例子，如下

```swift
struct CharacterCount14 : ParsableCommand {
    // Input:
    // $ ./character-count3 Alice --multiplier 3
    
    @Argument(help: "String to count the characters of") var string: String
    @Option(
      help: "The number to multiply the count against.",
      transform: ({ Int($0)! == 0 ? 1 : Int($0)! })) var multiplier: Int
    
    func run() throws {
        print(string.count * multiplier)
    }
}
```



### (3) 使用@Flag

@Flag一般结合Bool类型的变量使用。举个例子，如下

```swift
struct CharacterCount15 : ParsableCommand {
    // Input:
    // $ ./character-count3 "Pullip Classical Alice" --ignoring-white-space
    
    @Argument(help: "String to count the characters of") var string: String
    
    @Flag(help: "When set, it ignores whitespace characters") var ignoringWhiteSpace: Bool = false
    // Note: error when not set initial value
    //@Flag(help: "When set, it ignores whitespace characters") var ignoringWhiteSpace: Bool
    
    func run() throws {
        print(ignoringWhiteSpace ? string.filter { $0 != " " }.count : string.count)
    }
}
```



#### a. Flag的长短名

通过name参数配置长短名



#### b. Flag的inversion参数

Flag的inversion参数是一个FlagInversion类型，它对应有2个类型

```swift
public struct FlagInversion: Hashable {
  ...  
  /// Adds a matching flag with a `no-` prefix to represent `false`.
  ///
  /// For example, the `shouldRender` property in this declaration is set to
  /// `true` when a user provides `--render` and to `false` when the user
  /// provides `--no-render`:
  ///
  ///     @Flag(name: .customLong("render"), inversion: .prefixedNo)
  ///     var shouldRender: Bool
  public static var prefixedNo: FlagInversion {
    self.init(base: .prefixedNo)
  }
  
  /// Uses matching flags with `enable-` and `disable-` prefixes.
  ///
  /// For example, the `extraOutput` property in this declaration is set to
  /// `true` when a user provides `--enable-extra-output` and to `false` when
  /// the user provides `--disable-extra-output`:
  ///
  ///     @Flag(inversion: .prefixedEnableDisable)
  ///     var extraOutput: Bool
  public static var prefixedEnableDisable: FlagInversion {
    self.init(base: .prefixedEnableDisable)
  }
}
```

prefixedNo表示使用--no-xxx/--xxx命名开关，而prefixedEnableDisable表示使用--enable--xxx/--disable-xxx命名开关。



举个官方的例子[^8]，如下

```swift
struct Example: ParsableCommand {
    @Flag(inversion: .prefixedNo)
    var index = true

    @Flag(inversion: .prefixedEnableDisable)
    var requiredElement: Bool

    mutating func run() throws {
        print(index, requiredElement)
    }
}
```



#### c. Flag接收枚举值

可以使用@Flag修饰一个枚举类型的数组变量，这样可以接收多个枚举值参数。举个例子，如下

```swift
struct CharacterCount18 : ParsableCommand {
    // Input:
    // $ ./character-count3 "Pullip Al1ce" --whitespace --numbers
    
    // Note: use EnumerableFlag instead of String, CaseIterable
    // https://apple.github.io/swift-argument-parser/documentation/argumentparser/flag
    enum CharSet: EnumerableFlag /*String, CaseIterable*/ {
      case whitespace
      case numbers
      case vowels
    }
    
    @Argument(help: "String to count the characters of") var string: String
    @Flag(help: "Character sets to ignore") var characterSets: [CharSet]
    
    func run() throws {
        var allChars = [String]()
        if characterSets.contains(.whitespace) {
          string.forEach { if $0 == " " { allChars += [String($0)] } }
        }
        
        if characterSets.contains(.numbers) {
          let numbers = (0...9).map { "\($0)" }
          string.forEach { if numbers.contains(String($0)) { allChars += [String($0)] } }
        }
        
        if characterSets.contains(.vowels) {
          let vowels = ["a", "e", "i", "o", "u"]
          string.forEach { if vowels.contains(String($0.lowercased())) { allChars += [String($0)] } }
        }
        
        print(allChars.count)
    }
}
```



## 4、校验参数

再看看ParsableArguments的定义，如下

```swift
public protocol ParsableArguments: Decodable {
  /// Creates an instance of this parsable type using the definitions
  /// given by each property's wrapper.
  init()
  
  /// Validates the properties of the instance after parsing.
  ///
  /// Implement this method to perform validation or other processing after
  /// creating a new instance from command-line arguments.
  mutating func validate() throws
  
  /// The label to use for "Error: ..." messages from this type. (experimental)
  static var _errorLabel: String { get }
}
```

它有一个validate函数，实现类可以通过这个函数来校验命令行参数[^5]。

举个例子，如下

```swift
struct CharacterCount19 : ParsableCommand {
    // Input:
    // $ ./character-count3 "hi"
    
    @Argument(help: "String to count the characters of") var string: String
    
    mutating func validate() throws {
        if string.count < 3 {
            throw ValidationError("'string' must contain at least 3 characters.")
        }
    }
    
    func run() {
        print(string.count)
    }
}
```

ValidationError类型也是ArgumentParser提供的，它的定义如下

```swift
public struct ValidationError: Error, CustomStringConvertible {
  /// The error message represented by this instance, this string is presented to
  /// the user when a `ValidationError` is thrown from either; `run()`,
  /// `validate()` or a transform closure.
  public internal(set) var message: String
  
  /// Creates a new validation error with the given message.
  public init(_ message: String) {
    self.message = message
  }
  
  public var description: String {
    message
  }
}
```

上面的输出效果，如下

```shell
Error: 'string' must contain at least 3 characters.
Usage: character-count19 <string>
  See 'character-count19 --help' for more information.
```



也可以在run函数直接抛出异常。举个例子，如下

```swift
struct CharacterCount20 : ParsableCommand {
    // Input:
    // $ ./character-count3 "hi"
    
    @Argument(help: "File to count the characters of") var filePath: String
    
    func run() throws {
        let contents = try String(contentsOfFile: filePath, encoding: .utf8)
        print(contents.count)
    }
}

```

上面的输出效果，如下

```shell
Error: The file “12” couldn’t be opened because there is no such file.
```





## 5、Subcommand

ArgumentParser支持命令下面有子命令(subcommand)，而且子命令也是实现ParsableCommand协议。

举个例子，如下

```swift
struct CharacterCount22: ParsableCommand {
    
    // Input:
    // $ ./CharacterCount22 direct-string "Alice"
    static let configuration = CommandConfiguration(subcommands: [DirectString.self])
  
    // Note: use EnumerableFlag instead of String, CaseIterable
    // https://apple.github.io/swift-argument-parser/documentation/argumentparser/flag
    enum CountingConfiguration: EnumerableFlag /*String, CaseIterable*/ {
      case all
      case uppercaseOnly
      case lowercaseOnly
    }
    
    struct Options: ParsableArguments {
        @Flag(help: "The kind of characters to count") var countingConfig: CountingConfiguration = CountingConfiguration.all
      
        @Flag(help: "If set, ignores whitespace characters") var ignoringWhitespace: Bool = false
      
        @Option(help: "Multiplies the end result by the specified number") var multiplier: Int = 1
    }
}

extension CharacterCount22 {
    struct DirectString: ParsableCommand {
        @Argument(help: "The string to count the characters of") var string: String
        
        func run() {
            print(string.count)
        }
    }
}
```

上面DirectString是一个子命令。使用`./executable direct-string --help`，可以调用它。

通过定义CommandConfiguration变量，来添加多个子命令的实现类。

说明

> 上面的代码存在一个问题：子命令无法使用@Flag等定义的变量。



### (1) 使用@OptionGroup

使用@OptionGroup可以将父命令定义的可选参数和Flag参数传递到子命令中[^6]。

举个例子，如下

```swift
struct CharacterCount23: ParsableCommand {
    
    // Input:
    // $ ./CharacterCount23 direct-string "Pullip Classical Alice"
    // $ ./CharacterCount23 direct-string "Pullip Classical Alice" --ignoring-whitespace
    // $ ./CharacterCount23 direct-string "Pullip Classical Alice" --ignoring-whitespace --multiplier 3
    static let configuration = CommandConfiguration(subcommands: [DirectString.self])
  
    enum CountingConfiguration: EnumerableFlag /*String, CaseIterable*/ {
      case all
      case uppercaseOnly
      case lowercaseOnly
    }
    
    struct Options: ParsableArguments {
        @Flag(help: "The kind of characters to count") var countingConfig: CountingConfiguration = CountingConfiguration.all
      
        @Flag(help: "If set, ignores whitespace characters") var ignoringWhitespace: Bool = false
      
        @Option(help: "Multiplies the end result by the specified number") var multiplier: Int = 1
    }
}

extension CharacterCount23 {
    struct DirectString: ParsableCommand {
        @Argument(help: "The string to count the characters of") var string: String
        
        @OptionGroup() var parentOptions: Options
        
        func run() {
            let whiteSpacechars = string.filter { $0 == " " }.count
            let alwaysSubtract = parentOptions.ignoringWhitespace ? whiteSpacechars : 0
            let mult = parentOptions.multiplier
            
            if parentOptions.countingConfig == .all {
                print((string.count - alwaysSubtract) * mult)
            }
            
            if parentOptions.countingConfig == .uppercaseOnly {
                let count = string.filter { $0.isUppercase }.count
                print((count - alwaysSubtract) * mult)
            }
            
            if parentOptions.countingConfig == .lowercaseOnly {
                let count = string.filter { $0.isLowercase }.count
                print((count - alwaysSubtract) * mult)
            }
        }
    }
}
```



### (2) 多个子命令的例子

举个例子，如下

```swift
struct CharacterCount24: ParsableCommand {
    
    // Input:
    // $ ./CharacterCount24 direct-string "Pullip Classical Alice"
    // $ ./CharacterCount24 direct-string "Pullip Classical Alice" --ignoring-whitespace
    // $ ./CharacterCount24 direct-string "Pullip Classical Alice" --ignoring-whitespace --multiplier 3
    static let configuration = CommandConfiguration(
        subcommands: [
          DirectString.self,
          RemoteFile.self,
          LocalFile.self
        ]
    )
  
    enum CountingConfiguration: EnumerableFlag /*String, CaseIterable*/ {
      case all
      case uppercaseOnly
      case lowercaseOnly
    }
    
    struct Options: ParsableArguments {
        @Flag(help: "The kind of characters to count") var countingConfig: CountingConfiguration = CountingConfiguration.all
      
        @Flag(help: "If set, ignores whitespace characters") var ignoringWhitespace: Bool = false
      
        @Option(help: "Multiplies the end result by the specified number") var multiplier: Int = 1
    }
}

// MARK: - DirectString subcommand

extension CharacterCount24 {
    struct DirectString: ParsableCommand {
        @Argument(help: "The string to count the characters of") var string: String
        
        @OptionGroup() var parentOptions: Options
        
        func run() {
            let whiteSpacechars = string.filter { $0 == " " }.count
            let alwaysSubtract = parentOptions.ignoringWhitespace ? whiteSpacechars : 0
            let mult = parentOptions.multiplier
            
            if parentOptions.countingConfig == .all {
                print((string.count - alwaysSubtract) * mult)
            }
            
            if parentOptions.countingConfig == .uppercaseOnly {
                let count = string.filter { $0.isUppercase }.count
                print((count - alwaysSubtract) * mult)
            }
            
            if parentOptions.countingConfig == .lowercaseOnly {
                let count = string.filter { $0.isLowercase }.count
                print((count - alwaysSubtract) * mult)
            }
        }
    }
}

// MARK: - LocalFile subcommand

extension CharacterCount24 {
  struct LocalFile: ParsableCommand {
    @Argument(help: "A path to a local file to count the characters of") var localFile: String
    
    @OptionGroup() var parentOptions: Options
    
    func run() {
      do {
        let string = try String(contentsOfFile: localFile)
        processString(string: string, options: parentOptions)
      } catch {
        print("Unable to open local file")
      }
    }
  }
}

// MARK: - RemoteFile subcommand

extension CharacterCount24 {
  struct RemoteFile: ParsableCommand {
    @Argument(help: "The URL of the remote file to count the characters of", transform: { URL(string: $0)! }) var remoteFile: URL
    
    @OptionGroup() var parentOptions: Options
    
    func run() {
      do {
        let string = try String(contentsOf: remoteFile)
        processString(string: string, options: parentOptions)
      } catch {
        print("Unable to open local file")
      }
    }
  }
}

func processString(string: String, options: CharacterCount24.Options) {
  let whiteSpacechars = string.filter { $0 == " " }.count
  let alwaysSubstract = options.ignoringWhitespace ? whiteSpacechars : 0
  let mult = options.multiplier
  
  if options.countingConfig == .all {
    print((string.count - alwaysSubstract) * mult)
  }
  
  if options.countingConfig == .uppercaseOnly {
    let count = string.filter { $0.isUppercase }.count
    print((count - alwaysSubstract) * mult)
  }
  
  if options.countingConfig == .lowercaseOnly {
    let count = string.filter { $0.isLowercase }.count
    print((count - alwaysSubstract) * mult)
  }
}
```

使用@OptionGroup方式，存在一定缺点：在父命令中要定义所有子命令需要的参数(Option和Flag等)，而不是分布在每个子命令中。

它适合子命令区分处理固定参数，而共用Option和Flag等的场景。



## 6、配置参数的帮助信息

### (1) 使用ArgumentHelp对象

@Argument、@Option和@Flag，都有一个help参数，可以接收ArgumentHelp对象[^7]。

举个例子，如下

```swift
struct CharacterCount25 : ParsableCommand {
    // Input:
    // $ ./character-count3 "hi"
    
    @Argument(help:
        ArgumentHelp(
          "The string parameter will be counted against the specified character sets",
          discussion: "This obligatory parameter will be used to count the characters of.",
          valueName: "theString",
          visibility: .default)) var string: String
    
    mutating func validate() throws {
        if string.count < 3 {
            throw ValidationError("'string' must contain at least 3 characters.")
        }
    }
    
    func run() {
        print(string.count)
    }
}
```



### (2) 配置CommandConfiguration对象

CommandConfiguration初始化有commandName、abstract、discussion等。

举个例子，如下

```swift
struct CharacterCount26: ParsableCommand {
    
    // Input:
    // $ ./CharacterCount26 direct-string "Alice"
    static let configuration = CommandConfiguration(
        commandName: "CharacterCounter",
        abstract: "Allows you to count the number of characters in a string",
        discussion: "A string is a made up of multiple characters. A character can be human-readable or a control character. When counting characters, you may need to know if you want to consider control characters or not, as the results may vary.",
        subcommands: [DirectString.self])
    
    enum CountingConfiguration: EnumerableFlag /*String, CaseIterable*/ {
      case all
      case uppercaseOnly
      case lowercaseOnly
    }
    
    struct Options: ParsableArguments {
        @Flag(help: "The kind of characters to count") var countingConfig: CountingConfiguration = CountingConfiguration.all
      
        @Flag(help: "If set, ignores whitespace characters") var ignoringWhitespace: Bool = false
      
        @Option(help: "Multiplies the end result by the specified number") var multiplier: Int = 1
    }
}

extension CharacterCount26 {
    struct DirectString: ParsableCommand {
        @Argument(help: "The string to count the characters of") var string: String
        
        func run() {
            print(string.count)
        }
    }
}
```



## 7、执行异步任务

如果命令需要执行异步任务，这篇文章[^9]提到使用semaphore方式，将run函数等待异步任务完成。



## 8、命令行工具安装

这篇文章[^10]建议命令行工具安装下面的路径

```shell
/usr/local/bin
```



## 9、常见任务

### (1) 获取原始命令行字符串

通过CommandLine.arguments可以获取原始命令行字符串，然后在validate函数中自己处理字符串，并提前结束ArgumentParser的处理。

举个例子，如下

```swift
struct GetOriginalInputString: ParsableCommand {
    
    // Input:
    // $ ./GetOriginalInputString direct-string --help
    static let configuration = CommandConfiguration(
        commandName: "GetOriginalInputString",
        abstract: "Allows you to count the number of characters in a string",
        discussion: "A string is a made up of multiple characters. A character can be human-readable or a control character. When counting characters, you may need to know if you want to consider control characters or not, as the results may vary.",
        subcommands: [DirectString.self])
}

extension GetOriginalInputString {
    struct DirectString: ParsableCommand {
        @Argument()
        var string: String?
        
        func validate() throws {
            print(string ?? "")
            print(CommandLine.arguments)
            var arguments:[String] = [String]()
            arguments.append(contentsOf: CommandLine.arguments)
            arguments.removeFirst()
            arguments.removeFirst()
            _ = runCommand(command: "surgeon", arguments: arguments)
            GetOriginalInputString.exit()
        }
        
        func runCommand(command: String, arguments: [String]) -> Int32 {
            let task = Process()
            task.launchPath = NSHomeDirectory() + "/8/../5/" + command
            task.arguments = arguments
            task.launch()
            task.waitUntilExit()
            return task.terminationStatus
        }
    }
}
```



### (2) 支持命令行可组合

这篇文章[^3]提出命令行工具和命令行应用的区别在于：

* 命令行应用：特定业务领域的工具，比如docker

* 命令行工具：相对通用的工具，而且可以组合使用。比如grep、find等



原文描述，如下

> I differentiate between a command-line tool and a command-line application, in the following manner:
>
> - command-line application: a self-contained program that only deals with a specific domain. Think of the command-line application `docker`. Its only purpose is to manage Docker containers and resources.
> - command-line tool: built to accomplish a specific task, but it can be composable. Think of the command-line tools `grep(1)`, `find(1)`, `cat(1)`, `sort(1)`.



如果要实现可组合的命令行工具，则需要读取stdin。

这篇文章[^11]给出示例代码，如下

```swift
print("Please enter your name:")

if let name = readLine() {
    print("Hello, \(name)!")
} else {
    print("Why are you being so coy?")
}

print("TTFN!")
```

实际上是应用readLine函数，把它结合到ArgumentParser。举个例子，如下

```swift
struct Colorico: ParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: "Colorico adds colour to text using Console Escape Sequences",
        version: "1.0.0"
    )
    
    enum Colour: Int {
        case red = 31
        case green = 32
    }
    
    @Argument(help: "text to colour.")
    var text: String

    @Flag(inversion: .prefixedNo)
    var good = true

    @Option(name: [.customShort("o"), .long], help: "name of output file(the command only writes to current directory)")
    var outputFile: String?
    
    func run() throws {
        var colour = Colour.green.rawValue
        if !good {
            colour = Colour.red.rawValue
        }
        let colouredText = "\u{1B}[\(colour)m\(text)\u{1B}[0m"
        if let outputFile = outputFile {
            let path = FileManager.default.currentDirectoryPath

            //Lets prevent any directory traversal
            let filename = URL(fileURLWithPath: outputFile).lastPathComponent
            let fullFilename = URL(fileURLWithPath: path).appendingPathComponent(filename)
            try colouredText.write(to: fullFilename, atomically: true, encoding: String.Encoding.utf8)
        } else {
            print(colouredText)
        }
    }
}

func readSTDIN () -> String? {
    var input: String?

    // Note: press Crtl+D to make readLine() to return nil and finish the while loop
    while let line = readLine() {
        if input == nil {
            input = line
        } else {
            // Note: readline's parameter strippingNewline is true by default,
            // so add a newline character manually
            input! += "\n" + line
        }
    }

    return input
}

class ComposableCommand {
    var text: String?
    
    func main() -> Void {
        if CommandLine.arguments.count == 1 || CommandLine.arguments.last == "-" {
            if CommandLine.arguments.last == "-" { CommandLine.arguments.removeLast() }
            text = readSTDIN()
        }

        var arguments = Array(CommandLine.arguments.dropFirst())
        if let text = text {
            arguments.insert(text, at: 0)
        }

        let command = Colorico.parseOrExit(arguments)
        do {
            try command.run()
        } catch {

            Colorico.exit(withError: error)
        }
    }
}
```

上面没有调用ParsableCommand的main方法，而且手动预处理的命令行字符串，并将它传给Colorico类。



# References

[^1]:https://www.avanderlee.com/swift/property-wrappers/
[^2]:https://docs.swift.org/swift-book/LanguageGuide/Properties.html#ID617
[^3]:https://rderik.com/blog/understanding-the-swift-argument-parser-and-working-with-stdin/#working-with-stdin
[^4]:https://www.andyibanez.com/posts/writing-commandline-tools-argumentparser-part1/
[^5]:https://www.andyibanez.com/posts/writing-commandline-tools-argumentparser-part2/

[^6]:https://www.andyibanez.com/posts/writing-commandline-tools-argumentparser-part3/
[^7]:https://www.andyibanez.com/posts/writing-commandline-tools-argumentparser-part4/
[^8]: https://apple.github.io/swift-argument-parser/documentation/argumentparser/declaringarguments/
[^9]:https://www.andyibanez.com/posts/writing-commandline-tools-argumentparser-part5/
[^10]:https://www.andyibanez.com/posts/writing-commandline-tools-argumentparser-part6/
[^11]:https://www.hackingwithswift.com/example-code/system/how-do-you-read-from-the-command-line

