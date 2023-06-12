//
//  Test_generic.swift
//  Test
//
//  Created by wesley_chen on 2022/3/20.
//

import XCTest

protocol Container {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

struct IntStack: Container {
    // original IntStack implementation
    var items: [Int] = []
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    
    // Note: define typealias is optional, you can comment it out
    // conformance to the Container protocol
    //typealias Item = Int
    mutating func append(_ item: Int) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
}

struct Stack<Element>: Container {
    // original Stack<Element> implementation
    var items: [Element] = []
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    // conformance to the Container protocol
    mutating func append(_ item: Element) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
}

class Test_generic: XCTestCase {
    func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
        let temporaryA = a
        a = b
        b = temporaryA
    }
    
    func test_swapTwoValues() throws {
        var someInt = 3
        var anotherInt = 107
        swapTwoValues(&someInt, &anotherInt)
        // someInt is now 107, and anotherInt is now 3
        XCTAssertEqual(someInt, 107)
        XCTAssertEqual(anotherInt, 3)

        var someString = "hello"
        var anotherString = "world"
        swapTwoValues(&someString, &anotherString)
        // someString is now "world", and anotherString is now "hello"
        XCTAssertEqual(someString, "world")
        XCTAssertEqual(anotherString, "hello")
    }
    
    func test_IntStack() throws {
        var stack: IntStack = IntStack()
        stack.push(1)
        stack.push(2)
        stack.push(3)
        XCTAssertTrue(stack.count == 3)
    }
    
    func test_Stack() throws {
        // Case 1
        var intStack: Stack = Stack<Int>()
        intStack.push(1)
        intStack.push(2)
        intStack.push(3)
        XCTAssertTrue(intStack.count == 3)
        
        // Case 1
        var stringStack: Stack = Stack<String>()
        stringStack.push("1")
        stringStack.push("2")
        XCTAssertTrue(stringStack.count == 2)
    }
    
    func anyCommonElements<T: Sequence, U: Sequence>(_ lhs: T, _ rhs: U) -> Bool
        where T.Element: Equatable, T.Element == U.Element
    {
        for lhsItem in lhs {
            for rhsItem in rhs {
                if lhsItem == rhsItem {
                    return true
                }
            }
        }
        return false
    }
    
    func anyCommonElements2<T, U>(_ lhs: T, _ rhs: U) -> Bool
        where T: Sequence, U: Sequence, T.Element: Equatable, T.Element == U.Element
    {
        for lhsItem in lhs {
            for rhsItem in rhs {
                if lhsItem == rhsItem {
                    return true
                }
            }
        }
        return false
    }
    
    func testExample() throws {
        let hasAnyCommonElement = anyCommonElements([1, 2, 3], [3])
        print(hasAnyCommonElement)
        
        let hasAnyCommonElement2 = anyCommonElements([1, 2, 3], [3])
        print(hasAnyCommonElement2)
    }
}
