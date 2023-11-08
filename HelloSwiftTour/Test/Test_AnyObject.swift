//
//  Test_AnyObject.swift
//  Test
//
//  Created by wesley_chen on 2023/11/8.
//

import XCTest

class FloatRef {
    let value: Float
    init(_ value: Float) {
        self.value = value
    }
}

final class Test_AnyObject: XCTestCase {
    func test_concrete_object_convert_to_AnyObject_type() throws {
        let x = FloatRef(2.3)
        let y: AnyObject = x
        let z: AnyObject = FloatRef.self
        
        dump_object(x)
        dump_object(y)
        dump_object(z)
        print("")
    }
}
