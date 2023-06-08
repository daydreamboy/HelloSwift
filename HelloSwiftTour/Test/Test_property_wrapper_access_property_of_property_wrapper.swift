//
//  Test_property_wrapper_access_property_of_property_wrapper.swift
//  Test
//
//  Created by wesley_chen on 2022/6/5.
//

import XCTest

// Note: set the UserDefaultType3 only to SWIFT_ACTIVE_COMPILATION_CONDITIONS
// @see https://stackoverflow.com/a/39435346
#if UserDefaultType4

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

    @UserDefault(key: "username", defaultValue: "Antoine van der Lee")
    static var username: String

    @UserDefault(key: "year_of_birth", defaultValue: 1990)
    static var yearOfBirth: Int
}

extension UserDefaults {
    static func printPrivateProperties() {
        // Through underscore
        print(_hasSeenAppIntroduction.key)

        // Through projected value
        print($hasSeenAppIntroduction.key)
    }
}

private class Test_property_wrapper_access_property_of_property_wrapper: XCTestCase {
    func test_access_property_of_property_wrapper() throws {
        UserDefaults.printPrivateProperties()
    }
}

#endif
