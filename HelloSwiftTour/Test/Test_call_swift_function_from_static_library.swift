//
//  Test_call_swift_function_from_static_library.swift
//  Test
//
//  Created by wesley_chen on 2023/6/10.
//

import XCTest
import SWStaticLibrary

final class Test_call_swift_function_from_static_library: XCTestCase {

    func test_call_swift_func_from_static_libray() throws {
        SWPublicTool.doSomething(videoPath: "") { success, error in
            
        }
    }
}
