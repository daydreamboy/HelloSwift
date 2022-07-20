//
//  Test_description.swift
//  Test
//
//  Created by wesley_chen on 2022/7/20.
//

import XCTest

class Test_description_SomeClass: NSObject {    
    // @see https://stackoverflow.com/a/24108931
    // @see https://stackoverflow.com/a/41666807
    override var description: String {
        return "<\(type(of: self)): \(Unmanaged.passUnretained(self).toOpaque()), foo = \(1)>"
    }
    
    // @see https://www.hackingwithswift.com/example-code/language/how-to-create-a-custom-debug-description
    override var debugDescription: String {
        return "<\(type(of: self)): \(Unmanaged.passUnretained(self).toOpaque()), foo = \(2)>"
    }
}

class Test_description: XCTestCase {

    func test_description() throws {
        let o = Test_description_SomeClass()
        // Note: print use description
        // lldb use debugDescription
        print(o)
        print("blah")
    }
}
