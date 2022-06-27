//
//  Test_WCStringStreamReader.swift
//  Test
//
//  Created by wesley_chen on 2022/6/27.
//

import XCTest

class Test_WCStringStreamReader: XCTestCase {
    func test_nextLine() throws {
        if let path = Bundle.main.path(forResource: "1", ofType: "txt"),
           let aStreamReader = WCDataStreamReader(path: path) {
            defer {
                aStreamReader.close()
            }
            
            // Example 1: use nextLine func
            while let line = aStreamReader.nextLine() {
                print("line\(aStreamReader.numberOfLines): \(line)")
            }
            
            print("total numberOfLines: \(aStreamReader.numberOfLines)")
        }
    }
    
    func test_makeIterator() throws {
        if let path = Bundle.main.path(forResource: "1", ofType: "txt"),
           let aStreamReader = WCDataStreamReader(path: path) {
            defer {
                aStreamReader.close()
            }
            
            // Example 2: use for-in
            for line in aStreamReader {
                print("line\(aStreamReader.numberOfLines): \(line)")
            }
            
            print("total numberOfLines: \(aStreamReader.numberOfLines)")
        }
    }
    
    func test_one_line_without_delimeter() throws {
        if let path = Bundle.main.path(forResource: "2", ofType: "txt"),
           let aStreamReader = WCDataStreamReader(path: path) {
            defer {
                aStreamReader.close()
            }
            
            for line in aStreamReader {
                print("line\(aStreamReader.numberOfLines): \(line)")
            }
            
            print("total numberOfLines: \(aStreamReader.numberOfLines)")
        }
    }
    
    func test_use_custom_delimeter() throws {
        // Case 1
        if let path = Bundle.main.path(forResource: "1", ofType: "txt"),
           let aStreamReader = WCDataStreamReader(path: path, delimiter: "\r\n") {
            defer {
                aStreamReader.close()
            }
            
            for line in aStreamReader {
                print("line\(aStreamReader.numberOfLines): \(line)")
            }
            
            print("total numberOfLines: \(aStreamReader.numberOfLines)")
            print("-------------------")
        }
        
        // Case 2
        if let path = Bundle.main.path(forResource: "1", ofType: "txt"),
           let aStreamReader = WCDataStreamReader(path: path, delimiter: "\r\n\r\n") {
            defer {
                aStreamReader.close()
            }
            
            for line in aStreamReader {
                print("line\(aStreamReader.numberOfLines): \(line)")
            }
            
            print("total numberOfLines: \(aStreamReader.numberOfLines)")
            print("-------------------")
        }
    }
}
