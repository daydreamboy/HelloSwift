//
//  Test_property_wrapper_define_customized_initializer.swift
//  Test
//
//  Created by wesley_chen on 2022/6/5.
//

import XCTest

// Note: set the UserDefaultType2 only to SWIFT_ACTIVE_COMPILATION_CONDITIONS
// @see https://stackoverflow.com/a/39435346
#if UserDefaultType2

/// Allows to match for optionals with generics that are defined as non-optional.
public protocol AnyOptional {
    /// Returns `true` if `nil`, otherwise `false`.
    var isNil: Bool { get }
}
// Note: the extension implements the AnyOptional protocol
extension Optional: AnyOptional {
    public var isNil: Bool { self == nil }
}

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
            // Check whether we're dealing with an optional and remove the object if the new value is nil.
            if let optional = newValue as? AnyOptional, optional.isNil {
                container.removeObject(forKey: key)
            } else {
                container.set(newValue, forKey: key)
            }
        }
    }

    var projectedValue: Bool {
        return true
    }
}

// MARK: - Define customized initializer

extension UserDefault where Value: ExpressibleByNilLiteral {
    
    /// Creates a new User Defaults property wrapper for the given key.
    /// - Parameters:
    ///   - key: The key to use with the user defaults store.
    init(key: String, _ container: UserDefaults = .standard) {
        self.init(key: key, defaultValue: nil, container: container)
    }
}

extension UserDefaults {
    // Note: use customized initializer
    @UserDefault(key: "year_of_birth")
    static var yearOfBirth: Int?
}

private class Test_property_wrapper_define_customized_initializer: XCTestCase {
    func test_customized_initializer() throws {
        UserDefaults.yearOfBirth = 1990
        print(UserDefaults.yearOfBirth as Any) // Prints: 1990
        UserDefaults.yearOfBirth = nil
        print(UserDefaults.yearOfBirth as Any) // Prints: nil
    }
}


#endif
