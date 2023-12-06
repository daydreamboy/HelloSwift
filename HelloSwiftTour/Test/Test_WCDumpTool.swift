//
//  Test_WCDumpTool.swift
//  Test
//
//  Created by wesley_chen on 2023/11/8.
//

import XCTest
import UIKit

class Test_WCDumpTool_DummyClass {
    
}

final class Test_WCDumpTool: XCTestCase {
    func test_dump_object() throws {
        // objects
        let a: String = "abc"
        dump_object(a)
        dump_object(a as AnyObject)
        dump_object("abc")
        dump_object(Test_WCDumpTool_DummyClass())
        
        // classes
        dump_object(String.self)
        dump_object(NSString.self)
        dump_object(Test_WCDumpTool_DummyClass.self)
        
        // number vs string
        dump_object("100")
        dump_object(100)
        
        // function object
        dump_object({ (message: String) -> Void in print(message) })
        
        // tuple
        dump_object((3.0, 5.0))
        
        // dump view
        let view = UIView.init(frame: CGRect(x: 1, y: 2, width: 3, height: 4))
        dump_object(view)
    }
}
