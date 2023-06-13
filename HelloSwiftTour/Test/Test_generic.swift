//
//  Test_generic.swift
//  Test
//
//  Created by wesley_chen on 2022/3/20.
//

import XCTest

protocol Container {
    associatedtype Item: Equatable
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

struct Stack<Element: Equatable>: Container {
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

extension Array: Container where Array.Element: Equatable {}

extension Stack where Element: Equatable {
    func isTop(_ item: Element) -> Bool {
        guard let topItem = items.last else {
            return false
        }
        return topItem == item
    }
}

extension Container {
    func average() -> Double where Item == Int {
        var sum = 0.0
        for index in 0..<count {
            sum += Double(self[index])
        }
        return sum / Double(count)
    }
    func endsWith(_ item: Item) -> Bool where Item: Equatable {
        return count >= 1 && self[count-1] == item
    }
}

protocol SuffixableContainer: Container {
    associatedtype Suffix: SuffixableContainer where Suffix.Item == Item
    func suffix(_ size: Int) -> Suffix
}

extension Stack: SuffixableContainer {
    func suffix(_ size: Int) -> Stack {
        var result = Stack()
        for index in (count-size)..<count {
            result.append(self[index])
        }
        return result
    }
    // Inferred that Suffix is Stack.
}

class Test_generic: XCTestCase {
    // MARK: Example1
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
    
    // MARK: Example2
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
    
    // MARK: Example3
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
    
    // Note: change <T: Sequence, U: Sequence> to where T: Sequence, U: Sequence
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
    
    func test_anyCommonElements() throws {
        let hasAnyCommonElement = anyCommonElements([1, 2, 3], [3])
        print(hasAnyCommonElement)
        
        let hasAnyCommonElement2 = anyCommonElements([1, 2, 3], [3])
        print(hasAnyCommonElement2)
    }
    
    // MARK: Example4
    func allItemsMatch<C1: Container, C2: Container>
            (_ someContainer: C1, _ anotherContainer: C2) -> Bool
            where C1.Item == C2.Item, C1.Item: Equatable {

        // Check that both containers contain the same number of items.
        if someContainer.count != anotherContainer.count {
            return false
        }

        // Check each pair of items to see if they're equivalent.
        for i in 0..<someContainer.count {
            if someContainer[i] != anotherContainer[i] {
                return false
            }
        }

        // All items match, so return true.
        return true
    }
    
    func test_allItemsMatch() throws {
        var stackOfStrings = Stack<String>()
        stackOfStrings.push("uno")
        stackOfStrings.push("dos")
        stackOfStrings.push("tres")

        let arrayOfStrings = ["uno", "dos", "tres"]

        if allItemsMatch(stackOfStrings, arrayOfStrings) {
            print("All items match.")
        } else {
            print("Not all items match.")
        }
    }
    
    // MARK: Example5
    func test_isTop() throws {
        var stackOfStrings = Stack<String>()
        stackOfStrings.push("uno")
        stackOfStrings.push("dos")
        stackOfStrings.push("tres")
        
        if stackOfStrings.isTop("tres") {
            print("Top element is tres.")
        } else {
           print("Top element is something else.")
        }
    }
    
    // MARK: Example6
    func test_average() throws {
        let numbers = [1260, 1200, 98, 37]
        print(numbers.average())
        // Prints "648.75"
        print(numbers.endsWith(37))
        // Prints "true"
    }
    
    // MARK: Example7
    func test_suffix() throws {
        var stackOfInts = Stack<Int>()
        stackOfInts.append(10)
        stackOfInts.append(20)
        stackOfInts.append(30)
        let suffix = stackOfInts.suffix(2)
        print(suffix)
        // suffix contains 20 and 30
    }
}
