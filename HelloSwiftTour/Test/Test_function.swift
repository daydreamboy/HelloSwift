//
//  Test_function.swift
//  Test
//
//  Created by wesley_chen on 2022/3/20.
//

import XCTest

class Test_function: XCTestCase {
    // Note: use default label
    func greet(person: String, day: String) -> String {
        return "Hello \(person), today is \(day)."
    }
    
    // Note: use no label, and use a custom label
    func greet(_ person: String, on day: String) -> String {
        return "Hello \(person), today is \(day)!!!"
    }
    
    // MARK: Example1
    
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
    
    // MARK: Example2
    
    func defaultParametersBehind(parameterWithoutDefault: Int, parameterWithDefault: Int = 12) {
        // If you omit the second argument when calling this function, then
        // the value of parameterWithDefault is 12 inside the function body.
    }
    
    func defaultParametersAhead(parameterWithDefault: Int = 12, parameterWithoutDefault: Int) {
        // If you omit the second argument when calling this function, then
        // the value of parameterWithDefault is 12 inside the function body.
    }
    
    func test_default_parameter() throws {
        defaultParametersBehind(parameterWithoutDefault: 3, parameterWithDefault: 6) // parameterWithDefault is 6
        defaultParametersBehind(parameterWithoutDefault: 4) // parameterWithDefault is 12
        
        defaultParametersAhead(parameterWithoutDefault: 5)
        defaultParametersAhead(parameterWithDefault: 6, parameterWithoutDefault: 5)
    }
    
    // MARK: Example3
    
    func arithmeticMean(_ numbers: Double...) -> Double {
        var total: Double = 0
        for number in numbers {
            total += number
        }
        return total / Double(numbers.count)
    }
    
    func test_arithmeticMean() throws {
        var output: Double
        output = arithmeticMean(1, 2, 3, 4, 5)
        // returns 3.0, which is the arithmetic mean of these five numbers
        XCTAssertTrue(output == 3.0)
        XCTAssertFalse(output.isNaN)
        
        output = arithmeticMean(3, 8.25, 18.75)
        // returns 10.0, which is the arithmetic mean of these three numbers
        XCTAssertTrue(output == 10.0)
        XCTAssertFalse(output.isNaN)
        
        // Note: use isNaN to check, see https://stackoverflow.com/questions/24351377/which-is-the-swift-equivalent-of-isnan
        output = arithmeticMean()
        XCTAssertTrue(output.isNaN)
    }
    
    // MARK: Example4
    
    func swapTwoInts(_ a: inout Int, _ b: inout Int) {
        let temporaryA = a
        a = b
        b = temporaryA
    }
    
    func passInt(_ a: Int) {
        //a = 10 // Compile Error: Cannot assign to value: 'a' is a 'let' constant
    }
    
    func test_inout_parameters() throws {
        var someInt = 3
        var anotherInt = 107
        swapTwoInts(&someInt, &anotherInt)
        //swapTwoInts(someInt, anotherInt) // Compile Error: Passing value of type 'Int' to an inout parameter requires explicit '&'
        print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
        // Prints "someInt is now 107, and anotherInt is now 3"
    }
}
