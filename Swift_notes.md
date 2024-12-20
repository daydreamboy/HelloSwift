# Swift Notes

[TOC]

## Swift语法



### 1、_标号



```swift
_ = try? FileManager.default.removeItem(at: shmURL)
```

_标号而且没有变量，表示不关心返回值，即使没有返回值



### 2、??操作符（nil coalescing operator）

```swift
let coalescedHeight = height != nil ? height! : "" 等价于let coalescedHeight = height ?? ""
```



### 3、#available

运行时区分系统版本

```swift
func addPhoneNumber(phNo : String) {
  if #available(iOS 9.0, *) {
      let store = CNContactStore()
      let contact = CNMutableContact()
      let homePhone = CNLabeledValue(label: CNLabelHome, value: CNPhoneNumber(stringValue :phNo ))
      contact.phoneNumbers = [homePhone]
      let controller = CNContactViewController(forUnknownContact : contact)// .viewControllerForUnknownContact(contact)
      controller.contactStore = store
      controller.delegate = self
      self.navigationController?.setNavigationBarHidden(false, animated: true)
      self.navigationController!.pushViewController(controller, animated: true)
  }
}
```



### 4、类方法（static func）



公开类方法（static func）

```swift
class TableViewSectionItemsFactory {
    // 类方法
    static func sectionItems(for tableView: UITableView) -> [TableViewSectionItem] {
        return [
            adjustmentBehaviorSectionItem(for: tableView),
            insetsContentViewsToSafeAreaSectionItem(for: tableView),
            customCellsSectionItem(for: tableView)
        ]
    }
}
```



私有类方法（private static func）

```swift
private static func adjustmentBehaviorSectionItem(for tableView: UITableView) -> TableViewSectionItem {
        
        let sectionItem = TableViewSectionItem()
        // ...
        return sectionItem
    }
}
```



### 5、实例变量



#### （1）懒加载实例变量（lazy）

```swift
class TableViewCell: UITableViewCell {
  	// 懒加载实例变量
    lazy var customLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16.0)
        return label
    }()
}
```



#### （2）实例变量初始化

```swift
class TableViewSectionItem {
    var title: String?
    var headerHeight = CGFloat(60.0)
    var cellItems = [TableViewCellItem]()
}
```



### 6、重写父类方法（override）

```swift
class TableViewCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(customLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        customLabel.frame.origin.x = 5.0
        customLabel.frame.origin.y = 0.0
        customLabel.frame.size.width = contentView.bounds.width - 10.0
        customLabel.frame.size.height = contentView.bounds.height
    }
}
```



### 7、方法可选参数

```swift
class TableViewCellItem {
    
    typealias Handler = (() -> Void)
    
    var title: String
    var enabled: Bool
    var switchable: Bool
    var custom: Bool
    var height: CGFloat
    var selectionHandler: Handler?

  	// custom、switchable、enabled、height和selectionHandler是可选参数
    init(title: String,
         custom: Bool = false,
         switchable: Bool = false,
         enabled: Bool = false,
         height: CGFloat = 44.0,
         selectionHandler: Handler? = nil) {
        self.title = title
        self.custom = custom
        self.switchable = switchable
        self.enabled = enabled
        self.height = height
        self.selectionHandler = selectionHandler
    }
}
```



TODO

https://stackoverflow.com/questions/24014045/does-swift-have-dynamic-dispatch-and-virtual-methods?spm=ata.21736010.0.0.51bd3710p2P0yp&answertab=votes#tab-top



```
#if os(iOS) || os(watchOS) || os(tvOS)
    let color = UIColor.red
#elseif os(macOS)
    let color = NSColor.red
#else
    println("OMG, it's that mythical new Apple product!!!")
#endif
```

https://stackoverflow.com/questions/24065017/how-to-determine-device-type-from-swift-os-x-or-ios





TODO

check instance type

https://stackoverflow.com/questions/24091882/checking-if-an-object-is-a-given-type-in-swift



unicode literal

https://stackoverflow.com/questions/37111849/swift-string-literal-for-unicode-character-is-wrong





string subscript

// @see https://stackoverflow.com/a/58913649







## Reference