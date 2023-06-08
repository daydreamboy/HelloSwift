//
//  Test_property_wrapper_attach_to_function.swift
//  Test
//
//  Created by wesley_chen on 2022/6/5.
//

import XCTest

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

private class Test_property_wrapper_attach_to_function: XCTestCase {
    func runAnimation(@Debuggable(description: "Duration") withDuration duration: Double) {
        UIView.animate(withDuration: duration) {
            // ..
        }
    }

    func test_property_wrapper_attach_to_function() throws {
        runAnimation(withDuration: 2.0)
    }
    
    func test_property_wrapper_attach_to_closure() throws {
        struct Article {
            let title: String
        }

        let articleFactory: (String) -> Article = { (@Debuggable title) in
            return Article(title: title)
        }

        _ = articleFactory("Property Wrappers in Swift")
    }
}
