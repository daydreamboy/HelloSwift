//
//  Test_available.swift
//  Test
//
//  Created by wesley_chen on 2024/1/17.
//

import XCTest

@available(iOS 17, *)
class Test_available_NewClass {
    // A class that available on iOS 17 forward.
    func newMethod() {
        // Method that utilize iOS 17 features.
        print("\(#function) called")
    }
}

class Test_available_OldClass {
    @available(iOS 17, *)
    func newMethod() {
        // Method that utilize iOS 17 features.
        print("\(#function) called")
    }
    
    func oldMethod() {
        print("\(#function) called")
    }
}

final class Test_available: XCTestCase {
    func test_use_different_class() throws {
        if #available(iOS 17, *) {
            let newClass = Test_available_NewClass()
            newClass.newMethod()
        } else {
            let oldClass = Test_available_OldClass()
            oldClass.oldMethod()
        }
    }
    
    func test_use_different_method() throws {
        let oldClass = Test_available_OldClass()

        if #available(iOS 17, *) {
            oldClass.newMethod()
        } else {
            // Fallback on earlier versions
            oldClass.oldMethod()
        }
    }
}
