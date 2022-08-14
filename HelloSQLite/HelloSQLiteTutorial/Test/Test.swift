//
//  Test.swift
//  Test
//
//  Created by wesley_chen on 2022/8/14.
//

import XCTest
import SQLite3

class Test: XCTestCase {

    func test_check_SQLite3_version() throws {
        print("SQLITE_VERSION = \(SQLITE_VERSION)")
        print("SQLITE_VERSION_NUMBER = \(SQLITE_VERSION_NUMBER)")
        print("SQLITE_SOURCE_ID = \(SQLITE_SOURCE_ID)")
        
        print("sqlite3_libversion() = \(String.init(cString: sqlite3_libversion()))")
        print("sqlite3_sourceid() = \(String.init(cString: sqlite3_sourceid()))")
        print("sqlite3_libversion_number() = \(sqlite3_libversion_number())")
    }
}
