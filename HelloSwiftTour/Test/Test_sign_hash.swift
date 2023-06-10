//
//  Test_sign_hash.swift
//  Test
//
//  Created by wesley_chen on 2023/6/10.
//

import XCTest

final class Test_sign_hash: XCTestCase {

    func test_sign_hash_function() throws {
        // Case 1
        print(#function) // test_sign_hash_function()
        XCTAssertEqual(#function, "test_sign_hash_function()")
        
        // #function is String type
        print(type(of: #function))
        XCTAssertTrue(#function is String)
        
        // Case 2
        let output = dummy_func(path: "", completion: nil)  // dummy_func(path:completion:)
        XCTAssertEqual(output, "dummy_func(path:completion:)")
    }
    
    func test_sign_hash_selector() throws {
        // Case 1
        print(#selector(test_sign_hash_selector)) // test_sign_hash_selectorAndReturnError:
        
        // Case 2
        self.perform(#selector(dummy_func), with: "", with: nil)
    }
    
    func test_sign_hash_file() throws {
        print(#file) // test_sign_hash_function()
        XCTAssertEqual(#file, "/Users/wesley_chen/GitHub_Projects/HelloSwift/HelloSwiftTour/Test/Test_sign_hash.swift")
        
        // #file is String type
        print(type(of: #file))
        XCTAssertTrue(type(of: #file) == String.self)
        XCTAssertTrue(#file is String)
    }
    
    func test_sign_hash_line() throws {
        print(#line)
        XCTAssertEqual(#line, 39)
        
        // #file is Int type
        print(type(of: #line))
        XCTAssertTrue(type(of: #line) == Int.self)
        XCTAssertTrue(#line is Int)
    }
    
    func test_sign_hash_column() throws {
        print(#column)
        // Note: #column indicates the position of #, which index starts by 0
        // for example, 01234#, so #'s index is 5
        XCTAssertEqual(#column, 24)
        
        // #file is Int type
        print(type(of: #column))
        XCTAssertTrue(type(of: #column) == Int.self)
        XCTAssertTrue(#column is Int)
    }
    
    func test_sign_hash_warning() throws {
        #warning("This is a warning")
    }
    
    func test_sign_hash_error() throws {
        // Note: generate a compiler error
        //#error("This is an error")
    }
    
    // MARK: Dummy functions
    
    func dummy_func(path: String, completion: ((Bool, Error) -> Void)?) -> String {
        print("\(#function) called")
        return #function
    }
}
