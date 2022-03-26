//
//  Test_optional.swift
//  Test
//
//  Created by wesley_chen on 2022/3/26.
//

import XCTest

class Test_optional: XCTestCase {
    func test_optional_binding() throws {
        let possibleNumber = "123"
        
        // Note: use constant to bind the optional
        if let actualNumber = Int(possibleNumber) {
            print("The string \"\(possibleNumber)\" has an integer value of \(actualNumber)")
        } else {
            print("The string \"\(possibleNumber)\" couldn't be converted to an integer")
        }
        // Prints "The string "123" has an integer value of 123"
        
        // Note: use variable to bind the optional is also allowed
        if var actualNumber = Int(possibleNumber) {
            actualNumber = 456
            
            print("The string \"\(possibleNumber)\" has an integer value of \(actualNumber)")
        } else {
            print("The string \"\(possibleNumber)\" couldn't be converted to an integer")
        }
        // Prints "The string "123" has an integer value of 123"
    }
    
    func test_multiple_optional_binding() throws {
        if let firstNumber = Int("4"), let secondNumber = Int("42"), firstNumber < secondNumber && secondNumber < 100 {
            print("\(firstNumber) < \(secondNumber) < 100")
        }
        // Prints "4 < 42 < 100"

        if let firstNumber = Int("4") {
            if let secondNumber = Int("42") {
                if firstNumber < secondNumber && secondNumber < 100 {
                    print("\(firstNumber) < \(secondNumber) < 100")
                }
            }
        }
        // Prints "4 < 42 < 100"
    }
    
    // Note: if clause use short-circuit rule, firstNumber is nil, so no need to handle rest condition
    func test_multiple_optional_binding_shorthand() throws {
        if let firstNumber = Int("helloWorld"), let secondNumber = getNumber(), firstNumber < secondNumber && secondNumber < 100 {
            print("\(firstNumber) < \(secondNumber) < 100")
        }
    }
    
    func getNumber() -> Int? {
        print("getNumber called")
        return 42
    }
    
    func test_() throws {
        let possibleString: String? = "An optional string."
        let forcedString: String = possibleString! // requires an exclamation point

        let assumedString: String! = "An implicitly unwrapped optional string."
        let implicitString: String = assumedString // no need for an exclamation point

        let optionalString = assumedString
        // The type of optionalString is "String?" and assumedString isn't force-unwrapped.

        if assumedString != nil {
            print(assumedString!)
        }
        // Prints "An implicitly unwrapped optional string."

        if let definiteString = assumedString {
            print(definiteString)
        }
        // Prints "An implicitly unwrapped optional string."
    }
}
