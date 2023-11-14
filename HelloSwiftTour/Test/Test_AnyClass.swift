//
//  Test_AnyClass.swift
//  Test
//
//  Created by wesley_chen on 2023/11/14.
//

import XCTest

func getDefaultValue(_ c: AnyClass) -> Int? {
    return c.getDefaultValue?()
}

final class Test_AnyClass: XCTestCase {
    
    class IntegerRef {
        @objc class func getDefaultValue() -> Int {
            return 42
        }
    }

    func test_dynamic_dispatch_with_objc_method() throws {
        print(getDefaultValue(IntegerRef.self) as Any) // Prints "Optional(42)"
        print(getDefaultValue(NSString.self) as Any) // Prints "nil"
    }
}
