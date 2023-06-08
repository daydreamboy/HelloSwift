//
//  Test_property_wrapper_projected_value.swift
//  Test
//
//  Created by wesley_chen on 2022/6/5.
//

import XCTest

// Note: set the UserDefaultType3 only to SWIFT_ACTIVE_COMPILATION_CONDITIONS
// @see https://stackoverflow.com/a/39435346
#if UserDefaultType3

import Combine

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

private class Test_property_wrapper_projected_value: XCTestCase {
    func test_use_projected_value() throws {
        _ = UserDefaults.$username.sink { username in
            print("New username: \(username)")
        }
        UserDefaults.username = "Test"
        // Prints: New username: Test
    }
}

#endif


