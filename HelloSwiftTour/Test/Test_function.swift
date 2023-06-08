//
//  Test_function.swift
//  Test
//
//  Created by wesley_chen on 2022/3/20.
//

import XCTest

private class Test_function: XCTestCase {
    // Note: use default label
    func greet(person: String, day: String) -> String {
        return "Hello \(person), today is \(day)."
    }
    
    // Note: use no label, and use a custom label
    func greet(_ person: String, on day: String) -> String {
        return "Hello \(person), today is \(day)!!!"
    }
    
    func test_function_use_default_label() throws {
        var output = ""
        output = greet(person: "Bob", day: "Tuesday")
        print(output)
        
        // Error: the label order must be correct
        /*
        output = greet(day: "Tuesday", person: "Bob")
        print(output)
         */
    }
    
    func test_function_use_custom_label() throws {
        var output = ""
        output = greet("John", on: "Wednesday")
        print(output)
    }
}
