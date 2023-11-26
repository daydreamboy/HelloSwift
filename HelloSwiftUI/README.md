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



### (2) SwiftUI控件

SwiftUI控件类列表，如下

| 控件类              | 作用 |
| ------------------- | ---- |
| App                 |      |
| Button              |      |
| Image               |      |
| Label               |      |
| NavigationSplitView |      |
| Scene               |      |
| ScrollView          |      |
| Text                |      |
| View                |      |
| WindowGroup         |      |



### (3) SwiftUI布局

布局类，如下

| 布局类  | 作用 |
| ------- | ---- |
| ForEach |      |
| Group   |      |
| HStack  |      |
| List    |      |
| Spacer  |      |
| VStack  |      |
| ZStack  |      |







### (4) SwiftUI交互

| 类             | 作用 |
| -------------- | ---- |
| NavigationLink |      |



custom view init

TODO: https://stackoverflow.com/questions/56910854/swiftui-views-with-a-custom-init



### (5) SwiftUI property wrapper



| property wrapper   | 作用 |
| ------------------ | ---- |
| @Binding           |      |
| @State             |      |
| @Environment       |      |
| @EnvironmentObject |      |







## 3、SwiftUI和UIKit/AppKit混合使用

https://www.swiftbysundell.com/tips/swiftui-mix-and-match/



## 4、与SwiftUI相关的Xcode工具

### (1) Canvas

在Xcode中Editor > Canvas，可以显示SwiftUI的画布。Canvas有三种模式

* Live mode
  * 编辑代码，可以实时预览UI
* Selectable mode
  * 可以选中UI视图，同时高亮对应的代码位置
  * Command+Control点击视图，弹出视图Inspector，修改视图的属性，同样会在自动修改对应的代码
* Variants mode













## References

[^1]:https://www.hackingwithswift.com/quick-start/swiftui/what-is-swiftui
[^2]:https://developer.apple.com/xcode/swiftui/

