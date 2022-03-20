//
//  Test_generic.swift
//  Test
//
//  Created by wesley_chen on 2022/3/20.
//

import XCTest

class Test_generic: XCTestCase {
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
