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
| Toggle              |      |
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



### (5) SwiftUI绘图



### (6) SwiftUI动画





## 3、SwiftUI常用编程模式 

### (1) 特有property wrapper

| property wrapper   | 作用                                                         |
| ------------------ | ------------------------------------------------------------ |
| @Binding           | 数据绑定，子视图可以直接使用这个属性                         |
| @State             | 数据绑定，子视图不能直接使用这个属性，需要传递Binding类型变量 |
| @StateObject       | 数据绑定，和@State作用一样，适用于对象类型                   |
| @Environment       |                                                              |
| @EnvironmentObject |                                                              |







## 4、SwiftUI和UIKit/AppKit混合使用

https://www.swiftbysundell.com/tips/swiftui-mix-and-match/



## 5、与SwiftUI相关的Xcode工具

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

