//
//  Test_generic.swift
//  Test
//
//  Created by wesley_chen on 2022/3/20.
//

import XCTest

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
