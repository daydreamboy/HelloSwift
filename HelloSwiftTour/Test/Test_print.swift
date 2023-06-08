//
//  Test_print.swift
//  Test
//
//  Created by wesley_chen on 2022/3/26.
//

import XCTest

class Test_print: XCTestCase {
    func test_print() throws {
        // Case 1: pass string
        print("One two three four five")
        // Prints "One two three four five"

        // Case 2: pass range
        print(1...5)
        // Prints "1...5" string, not 1 2 3 4 5

        // Case 3: pass Double
        print(1.0, 2.0, 3.0, 4.0, 5.0)
        // Prints "1.0 2.0 3.0 4.0 5.0"
        
        // Case 4: use separator
        print(1.0, 2.0, 3.0, 4.0, 5.0, separator: " ... ")
        // Prints "1.0 ... 2.0 ... 3.0 ... 4.0 ... 5.0"
        
        // Case 5: use terminator
        for n in 1...5 {
            print(n, terminator: "")
        }
        // Prints "12345"
    }
}
