//
//  Test.swift
//  Test
//
//  Created by wesley_chen on 2023/5/31.
//

import XCTest

final class Test: XCTestCase {
    func test_append() throws {
        var value: Int? = nil
        var numbers = [1, 2, 3, 4, 5]
        numbers.append(value!)
        print(numbers)
    }
    
    func test_insert() throws {
        var numbers = [1, 2, 3, 4, 5]
        numbers.insert(100, at: 5)
        numbers.insert(100, at: 100) // Fatal error: Array index is out of range
        numbers.insert(200, at: numbers.endIndex)
    }
    
    func test_endIndex() throws {
        var numbers: [Int] = []
        
        // Case 1
        numbers = [10, 20, 30, 40, 50]
        XCTAssertTrue(numbers.endIndex == numbers.count)
        XCTAssertTrue(numbers.startIndex == 0)
        
        if let i = numbers.firstIndex(of: 30) {
            print(numbers[i ..< numbers.endIndex])
            XCTAssertEqual(numbers[i ..< numbers.endIndex], [30, 40, 50])
        }
        
        // Case 2
        numbers = []
        XCTAssertTrue(numbers.endIndex == 0)
    }
}
