//
//  Test_WCDumpTool.swift
//  Test
//
//  Created by wesley_chen on 2023/11/8.
//

import XCTest

class Test_WCDumpTool_DummyClass {
    
}

final class Test_WCDumpTool: XCTestCase {
    func test_dump_object() throws {
        let a: String = "abc"
        dump_object(a)
        dump_object(a as AnyObject)
        dump_object("abc")
        dump_object(String.self)
        dump_object(NSString.self)
        //
        dump_object(Test_WCDumpTool_DummyClass())
        dump_object(Test_WCDumpTool_DummyClass.self)
    }
}
