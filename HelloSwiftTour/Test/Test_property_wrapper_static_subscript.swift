//
//  Test_property_wrapper_static_subscript.swift
//  Test
//
//  Created by wesley_chen on 2022/6/5.
//

import XCTest

// Note: set the UserDefaultType3 only to SWIFT_ACTIVE_COMPILATION_CONDITIONS
// @see https://stackoverflow.com/a/39435346
#if UserDefaultType5

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

private class Test_property_wrapper_static_subscript: XCTestCase {

    func test_static_subscript() throws {
        Preferences.init().hasSeenAppIntroduction = true
        print(Preferences.init().hasSeenAppIntroduction)
    }
}

#endif
