# HelloSwiftUI

[TOC]

## 1、介绍SwiftUI

### (1) SwiftUI是什么

在iOS 13+，Apple引入SwiftUI framework，它提供声明式(declarative)的UI描述语法，用于实现App的UI。SwiftUI官方网址：https://developer.apple.com/xcode/swiftui/

对比UIKit，SwiftUI的优势在于

* 代码简洁。使用声明式语法，比命令式语法（UIKit），代码要少很多
  * 链式语法
* UI预览。不用运行App，依赖Xcode编译器，可以预览SwiftUI代码实现的UI视图
* 适用于多个Apple平台 (iOS、macOS、tvOS、watchOS、visionOS)[^1]

考虑到现有UI框架：UIKit和AppKit，SwiftUI可以和前两者混合使用。官方文档描述[^2]，如下

> SwiftUI is designed to work alongside UIKit and AppKit, so you can adopt it incrementally in your existing apps. When it’s time to construct a new part of your user interface or rebuild an existing one, you can use SwiftUI while keeping the rest of your codebase.
>
> And if you want to use an interface element that isn’t offered in SwiftUI, you can mix and match SwiftUI with UIKit and AppKit to take advantage of the best of all worlds.



一个UI框架应该具备以下能力：

布局和渲染：能够定义和管理视图的布局，并将其渲染到屏幕上。

事件处理：能够捕捉和处理用户的交互事件，如点击、滑动、拖拽等。

响应式设计：能够根据数据的变化自动更新视图，使用户界面保持同步。

组件化和复用：能够将界面划分为独立的组件，以便在应用程序中进行复用和组合。

动画和过渡效果：能够实现平滑的动画和过渡效果，以增强用户体验。

样式和主题：能够定义和应用样式和主题，以保持应用程序的一致性和可定制性。

响应式布局：能够根据屏幕尺寸和方向自适应地调整和布局视图。

多平台支持：能够在不同的平台（如iOS、macOS、watchOS和tvOS）上构建和运行应用程序。

图形和绘图：能够绘制和操作图形元素，如图标、图片、形状等。

层级和导航：能够组织和管理视图的层级关系，并支持导航和页面之间的转换。

数据绑定和状态管理：能够将数据绑定到视图上，并提供一种机制来管理视图的状态。

国际化和本地化：能够支持多语言和不同地区的本地化需求。

可访问性：能够提供可访问性支持，以确保应用程序能够被视觉障碍用户等特殊用户群体使用。

性能和优化：能够提供性能优化的功能和技术，以确保应用程序的流畅运行和响应。



### (2) SwiftUI常用文档

#### a. SwiftUI官方文档

https://developer.apple.com/documentation/swiftui



#### b. Tutorial系列之SwiftUI入门

https://developer.apple.com/tutorials/swiftui



#### c. Tutorial系列之SwiftUI概念

https://developer.apple.com/tutorials/swiftui-concepts/



#### d. 和UIKit混合使用文档

https://developer.apple.com/tutorials/swiftui/interfacing-with-uikit





## 2、SwiftUI常用概念

### (1) SwiftUI app结构



基础协议

| 协议  | 作用 |
| ----- | ---- |
| View  |      |
| Scene |      |





### (2) SwiftUI控件

这里的SwiftUI控件，是指用于显示的View。

SwiftUI控件类列表，如下

| 控件类              | 作用                                                         |
| ------------------- | ------------------------------------------------------------ |
| App                 |                                                              |
| Button              |                                                              |
| Capsule             | 胶囊形状的view。width > height时，帽型在左右；height > width时，帽型在上下；width == height时，是圆形 |
| Color               | 符合View协议                                                 |
|                     |                                                              |
| EmptyView           |                                                              |
| Image               |                                                              |
| Label               |                                                              |
| NavigationSplitView |                                                              |
| NavigationView      | iOS16.4已经废弃，推荐使用NavigationSplitView                 |
| Scene               | iOS 14+引入                                                  |
| ScrollView          |                                                              |
| Text                |                                                              |
| Toggle              |                                                              |
| View                |                                                              |
| WindowGroup         | iOS 14+引入                                                  |



### (3) SwiftUI布局

这里的SwiftUI布局，是指用于布局的View，这类View通常不会视图展示。

布局类，如下

| 布局类  | 作用                                                         |
| ------- | ------------------------------------------------------------ |
| ForEach |                                                              |
| Group   | 组合多个View成为一个单独控件，用于统一设置ViewModifier或者包装if-else显示逻辑 |
| HStack  |                                                              |
| List    |                                                              |
| Spacer  |                                                              |
| VStack  |                                                              |
| ZStack  |                                                              |



### (4) SwiftUI交互

| 类             | 作用 |
| -------------- | ---- |
| NavigationLink |      |



custom view init

TODO: https://stackoverflow.com/questions/56910854/swiftui-views-with-a-custom-init



### (5) SwiftUI绘图

| 类             | 作用                         |
| -------------- | ---------------------------- |
| Angle          |                              |
| GeometryReader | 创建一个自适应屏幕的view容器 |
| Path           |                              |





### (6) SwiftUI动画

| 类        | 作用                                                     |
| --------- | -------------------------------------------------------- |
| Animation | 用于配置动画的通用参数，例如线性、弹性、缓入缓出、延迟等 |
|           |                                                          |
|           |                                                          |



#### a. Equatable View和非Equatable View的动画

Equatable View和非Equatable View在执行动画时有所区别：

* Equatable View符合Equatable协议，SwiftUI根据Equatable协议判断出哪些属性变化，需要执行动画。一般使用`animation(_:)`修饰器即可。
* 非Equatable View，需要明确使用`animation(_:value:)`修饰器，指定哪个属性的值有变化，需要执行动画。

官方文档描述[^7]，如下

> When you use the `animation(_:)` modifier on an equatable view, SwiftUI animates any changes to animatable properties of the view. A view’s color, opacity, rotation, size, and other properties are all animatable. When the view isn’t equatable, you can use the `animation(_:value:)` modifier to start animations when the specified value changes.

说明

> 在iOS15+上，已经废弃`animation(_:)`修饰器，推荐使用`withAnimation(_:_:)`或者`animation(_:value:)` 



SwiftUI动画，一般分为两个步骤：

* 配置需要执行动画的属性，例如`.frame(width: 100 * scale, height: 100 * scale, alignment: .center)`、`.scaleEffect(scale, anchor: .leading)`等。通常会有一个@State变量来控制。
* 执行动画，通过`animation(_:value:)`修饰器或者withAnimation函数来执行@State变量的变更，达到执行动画的效果
  * `animation(_:value:)`修饰器，由于准确指定@State变量，执行动画，如果其他View也依赖这个@State变量，不会导致影响其他View也有动画
  * withAnimation函数，执行动画，如果其他View也依赖这个@State变量，也会产生动画效果。

说明

> 在上面提到过Equatable View，可以使用`animation(_:)`修饰器来执行动画，SwiftUI会自动计算Equatable View的哪些属性产生变化，然后根据`animation(_:)`修饰器设置的动画效果来执行动画。



#### b. 内置动画效果

View提供一些修饰器方法，用于设置内置的动画效果，例如`rotationEffect(_:anchor:)`等。如果要执行动画，则需要使用`animation(_:)`或`animation(_:value:)`来执行动画。

说明

> 可以设置多个`animation(_:)`或`animation(_:value:)`，如果其中一个函数的animation参数是nil，则优先使用这个函数，表示禁止执行动画。



##### i. 旋转动画

```swift
func rotationEffect(_ angle: Angle, anchor: UnitPoint = .center) -> some View
```

* angle：顺时针的旋转角度
* anchor：旋转的中心点



示例代码，如下

```swift
Text("Rotation by passing an angle in degrees")
    .rotationEffect(.degrees(22))
    .border(Color.gray)
```

上面代码设置Text的旋转，在UI显示时已经完成旋转。如果要交互式地执行动画，则使用`animation(_:)`或`animation(_:value:)`修饰器。

示例代码，如下

```swift
@Binding var title: String
@State private var rotationAngle: Double = 0

var body: some View {
    VStack {
        Button("Rotate") {
            rotationAngle += 20
        }

        Text("Rotation by passing an angle in degrees")
            .rotationEffect(.degrees(rotationAngle))
            .border(Color.gray)
            .animation(.easeInOut, value: rotationAngle)
    }
}
```



##### ii. 缩放动画

```swift
func scaleEffect(_ s: CGFloat, anchor: UnitPoint = .center) -> some View
```

* s：缩放的比例
* anchor：缩放的中心点



示例代码，如下

```swift
@State private var scale = 1.0

var body: some View {
    VStack {
        Image(systemName: "envelope.badge.fill")
            .resizable()
            .frame(width: 100, height: 100, alignment: .center)
            .foregroundColor(Color.red)
            .scaleEffect(scale, anchor: .leading)
            .border(Color.gray)
            .animation(.easeIn, value: scale)
        HStack {
            Button("+") { scale += 0.5 }
            Button("-") { scale -= 0.5 }
        }
    }
}
```



#### c. withAnimation函数（组动画）

withAnimation函数的签名，如下

```swift
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public func withAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result
```

相比于`animation(_:)`或`animation(_:value:)`修饰器，只能应用于单个View。而执行这个函数，可以完成一组动画，在withAnimation回调中，影响任何View（对withAnimation回调中@State变量有依赖的View）的animatable属性，都可以对这个View执行动画。

举个例子，如下

```swift
@State private var showDetail1 = false
@State private var showDetail2 = false

var body: some View {
    HStack {
        Button {
            showDetail1.toggle()
        } label: {
            Label("This is Button", systemImage: "chevron.right.circle")
                .labelStyle(.iconOnly)
                .imageScale(.large)
                .rotationEffect(.degrees(showDetail1 ? 90 : 0))
                .scaleEffect(showDetail1 ? 1.5 : 1)
                .padding()
        }

        Button {
            withAnimation {
                showDetail2.toggle()
            }
        } label: {
            Label("This is Button", systemImage: "chevron.right.circle")
                .labelStyle(.iconOnly)
                .imageScale(.large)
                .rotationEffect(.degrees(showDetail2 ? 90 : 0))
                .scaleEffect(showDetail2 ? 1.5 : 1)
                .padding()
        }
    }
}
```

上面两个按钮：第一个没有使用withAnimation函数，第二个按钮使用withAnimation函数，在该函数中执行showDetail2状态切换，任何用到showDetail2状态的属性，都会执行动画。

说明

> 上面代码在Canvas中是预期效果，但是在模拟器或真机上，可能第一个按钮也有动画效果。推测是SwiftUI版本不同版本，新版本使用隐式动画。
>
> 为了明确不使用动画，可以改成下面方式
>
> ```swift
> withAnimation(nil) {
>     showDetail1.toggle()
> }
> ```
>
> 



#### d. 过渡动画

使用transition函数可以执行过渡动画。它的签名，如下

```swift
func transition(_ t: AnyTransition) -> some View
```

该函数用于View显示或隐藏的过渡动画。官方文档描述，如下

> When this view appears or disappears, the transition will be applied to it, allowing for animating it in and out.

示例代码，如下

```swift
if isActive {
    MyView()
        .transition(.slide)
}
Button("Toggle") {
    withAnimation {
        isActive.toggle()
    }
}
```

这里使用了AnyTransition提供slide函数，它提供slide形式的动画。其他内置动画，如下

```swift
// 移动动画
static func move(edge: Edge) -> AnyTransition
// 平移动画。下面两者是等价的，写法不同
static func offset(_ offset: CGSize) -> AnyTransition
static func offset(x: CGFloat = 0, y: CGFloat = 0) -> AnyTransition
// 透明度动画
static let opacity: AnyTransition
// 移动动画加透明度动画
static func push(from edge: Edge) -> AnyTransition
// 缩放动画
static var scale: AnyTransition { get }
static func scale(scale: CGFloat, anchor: UnitPoint = .center) -> AnyTransition
// 滑动动画
static var slide: AnyTransition { get }
```



##### i. 自定义过渡动画

使用AnyTransition提供的asymmetric函数，可以指定appear和disappear时的特定动画。

使用AnyTransition提供的combined函数，可以组合动画。

举个例子，如下

```swift
VStack {
    Button("Toggle customized animation") {
        withAnimation(.easeInOut(duration: 2)) {
            toggleCustomized.toggle()
        }
    }
    if toggleCustomized {
        Rectangle()
            .fill(Color.blue)
            .frame(width: 100, height: 100)
            .transition(.asymmetric(
                insertion: .offset(x: -200, y: 0),
                removal: .offset(x: 200, y: 0)
            ))
        Rectangle()
            .fill(Color.orange)
            .frame(width: 100, height: 100)
            .transition(.asymmetric(
                insertion: .move(edge: .trailing).combined(with: .opacity),
                removal: .scale.combined(with: .opacity)
            ))
    } else {
        Color.clear
            .frame(height: 100)
        Color.clear
            .frame(height: 100)
    }
}
```







## 3、SwiftUI常用编程模式 

### (1) Single source of truth

Single source of truth是SwiftUI中使用的一个概念，表示UI呈现的数据都来自单一数据源。在声明式UI上，Apple遵循Single source of truth来保证UI上的数据一致性。

这篇文章介绍了Single source of truth的定义[^3]，个人觉得比较靠谱。

> **What is the Source of Truth?**
>
> Source of truth is a key concept in SwiftUI, and if you watch Apple’s Worldwide Developer Conference videos, you’ll hear them reiterate this concept over and over. They are essentially saying you need to decide upon a single place to store a piece of data, and have everywhere else read the same piece of data — hence the single source of truth.

在编写SwiftUI代码时，了解Single source of truth，有助于按照Apple的规范，设计自己的app数据流。同时，SwiftUI文档经常直接提到source of truth，方便理解Apple文档的含义。

说明

> 1. 不同于UIKit的命令式UI，UI的数据可能在代码中，也可能在xib中，因此UIKit是不符合Single source of truth的。
>
> 2. 命令式UI，UI的数据在代码中，也会细分为Model、ViewModel等，开发者要处理这些数据转换。相比下，Single source of truth的设计，要简化很多。



### (2) 特有property wrapper

| property wrapper   | 作用                                                         | 起始版本  |
| ------------------ | ------------------------------------------------------------ | --------- |
| @Binding           | 数据绑定，子视图可以直接使用这个变量                         | iOS 13.0+ |
| @State             | 数据绑定，属于当前视图，子视图不能直接使用这个变量，需要传递Binding类型变量 | iOS 13.0+ |
| @StateObject       | 数据绑定，和@State作用一样，适用于ObservableObject类型       | iOS 14.0+ |
| @Environment       |                                                              |           |
| @EnvironmentObject |                                                              |           |
| @Published         |                                                              |           |



#### a. @Binding

SwiftUI文档描述[^5]，如下

* @Binding是一个property wrapper，用于读写变量

  > A property wrapper type that can read and write a value owned by a source oftruth.

* @Binding，顾名思义，它是用于绑定其他变量，自身不存储数据

  > A binding connects a property to a source of truth stored elsewhere, instead of storing data directly.

容易混淆@Binding和@State的使用。举个例子说明，如下

```swift
struct PlayButtonWithBinding: View {
    @Binding var isPlaying: Bool // Play button now receives a binding.

    var body: some View {
        Button(isPlaying ? "Pause" : "Play") {
            isPlaying.toggle()
        }.border(.red)
    }
}
```

上面声明一个@Binding变量isPlaying，使用PlayButtonWithBinding，如下

```swift
struct PlayerView: View {
    @State private var isPlaying: Bool = false // Create the state here now.

    var body: some View {
        VStack {
            PlayButtonWithBinding(isPlaying: $isPlaying) // Pass a binding.
        }
    }
}
```

这里传递$isPlaying，相当于传递PlayerView中@State变量isPlaying的引用。

如果将PlayButtonWithBinding的@Binding变量isPlaying换成@State变量，如下

```swift
struct PlayButtonWithNotBinding: View {
    @State var isPlaying: Bool // Play button with its own state

    var body: some View {
        Button(isPlaying ? "Pause" : "Play") {
            isPlaying.toggle()
        }.border(.red)
    }
}
```

那么初始化PlayButtonWithNotBinding，只能按照值传递的方式，如下

```swift
struct PlayerView: View {
    @State private var isPlaying: Bool = false // Create the state here now.

    var body: some View {
        VStack {
            PlayButtonWithBinding(isPlaying: $isPlaying) // Pass a binding.
            PlayButtonWithNotBinding(isPlaying: isPlaying ? true : false) // Not pass a binding.
        }
    }
}
```

这里使用`$`来获取isPlaying变量的Binding类型，即@Binding，这样才能传参到PlayButtonWithBinding的初始化函数。

> 示例代码，见HelloDataFlow/UseBinding

区分@Binding和@State，可以简单理解为

* @Binding，用于引用其他变量
* @State，用于管理View自己的状态



#### b. @State

SwiftUI文档描述[^4]，如下

* @State是一个property wrapper，用于读写变量

  > A property wrapper type that can read and write a value managed by SwiftUI.

* 在视图层级中，可以使用@State作为单一数据源存储数据

  > Use state as the single source of truth for a given value type that you store in a view hierarchy. 

一般来说在View中使用@State声明的变量，那么这个变量的值就属于这个View的，举个例子，如下

```swift
struct PlayButtonWithPrivateState: View {
    @State private var isPlaying: Bool = false // Create the state.

    var body: some View {
        Button(isPlaying ? "Pause" : "Play") { // Read the state.
            isPlaying.toggle() // Write the state.
        }.border(.red)
    }
}
```

这里使用private修饰，主要避免和系统SwiftUI声明的变量冲突。

> Declare state as private to prevent setting it in a memberwise initializer, which can conflict with the storage management that SwiftUI provides

如何使用这个自定义View，如下

```swift
struct ContentView: View {
    var body: some View {
        VStack {
            PlayButtonWithPrivateState()
        }
    }
}
```

由于PlayButtonWithPrivateState的成员变量是private，因此PlayButtonWithPrivateState的初始化函数没有任何参数。



再举个@State是public修饰的例子，如下

```swift
struct PlayButtonWithPublicState: View {
    @State var isPlaying: Bool // Create the state.

    var body: some View {
        Button(isPlaying ? "Pause" : "Play") { // Read the state.
            isPlaying.toggle() // Write the state.
        }.border(.red)
    }
}
```

使用方式，如下

```swift
struct ContentView: View {
    var body: some View {
        VStack {
            PlayButtonWithPrivateState()
            PlayButtonWithPublicState(isPlaying: true)
        }
    }
}
```

由于变量isPlaying是public，编译器默认为PlayButtonWithPublicState创建一个带参数的初始化函数。

> 示例代码，见HelloDataFlow/UseState



#### c. @StateObject

@StateObject作用和@State一样，只能用于修饰ObservableObject类型。

官方文档描述[^6]，如下

> A property wrapper type that instantiates an observable object.

@State是用于存值类型，例如结构体、字符串、整型等。

> If you need to store a value type, like a structure, string, or integer, use the [`State`](https://developer.apple.com/documentation/swiftui/state) property wrapper instead.



### (3) ViewModifier

ViewModifier协议



| 函数   | 作用                                 |
| ------ | ------------------------------------ |
| offset | 偏移view，但是保留原始view占据的位置 |







### (4) ViewBuilder





## 4、常见问题

### (1) SwiftUI和UIKit/AppKit混合使用

https://www.swiftbysundell.com/tips/swiftui-mix-and-match/



### (2) SwiftUI中打印日志

参考[这个SO](https://stackoverflow.com/questions/56517813/how-to-print-to-xcode-console-in-swiftui)，直接使用下面代码，如下

```swift
let _ = print("hi!")
```





## 5、与SwiftUI相关的Xcode工具

### (1) Canvas

在Xcode中Editor > Canvas，可以显示SwiftUI的画布。Canvas有三种模式

* Live mode
  * 编辑代码，可以实时预览UI
* Selectable mode
  * 可以选中UI视图，同时高亮对应的代码位置
  * Command+Control点击视图，弹出视图Inspector，修改视图的属性，同样会在自动修改对应的代码
* Variants mode



## 6、iOS 17版本变化

### (1) 从ObservableObject协议迁移到@Observable宏





https://developer.apple.com/documentation/swiftui/migrating-from-the-observable-object-protocol-to-the-observable-macro?language=objc











## References

[^1]:https://www.hackingwithswift.com/quick-start/swiftui/what-is-swiftui
[^2]:https://developer.apple.com/xcode/swiftui/

[^3]:https://purple.telstra.com/blog/swiftui-source-of-truth
[^4]:https://developer.apple.com/documentation/swiftui/state#
[^5]:https://developer.apple.com/documentation/swiftui/binding#

[^6]:https://developer.apple.com/documentation/swiftui/stateobject#
[^7]:https://developer.apple.com/tutorials/swiftui/animating-views-and-transitions

