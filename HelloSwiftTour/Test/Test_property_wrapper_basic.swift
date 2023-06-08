//
//  Test_property_wrapper.swift
//  Test
//
//  Created by wesley_chen on 2022/6/3.
//

import XCTest

// Note: set the UserDefaultType1 only to SWIFT_ACTIVE_COMPILATION_CONDITIONS
// @see https://stackoverflow.com/a/39435346
#if UserDefaultType1

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

extension UserDefaults {
    // Note: there're two initializers for @UserDefault
    //@UserDefault(key: T##String, defaultValue: <#T##_#>, container: <#T##UserDefaults#>)
    //@UserDefault(key: <#T##String#>, defaultValue: <#T##_#>)
    @UserDefault(key: "has_seen_app_introduction", defaultValue: false)
    static var hasSeenAppIntroduction: Bool
}

class Test_property_wrapper_basic: XCTestCase {

    func test_use_property_wrapper() throws {
        UserDefaults.hasSeenAppIntroduction = false
        print(UserDefaults.hasSeenAppIntroduction) // Prints: false
        UserDefaults.hasSeenAppIntroduction = true
        print(UserDefaults.hasSeenAppIntroduction) // Prints: true
    }

}

#endif

