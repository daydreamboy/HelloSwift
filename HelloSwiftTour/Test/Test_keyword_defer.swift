//
//  Test_keyword_defer.swift
//  Test
//
//  Created by wesley_chen on 2022/3/20.
//

import XCTest

class Test_keyword_defer: XCTestCase {
    func test_defer() throws {
        var fridgeIsOpen = false
        let fridgeContent = ["milk", "eggs", "leftovers"]

        func fridgeContains(_ food: String) -> Bool {
            fridgeIsOpen = true
            // Note: use defer mark a code block will be executed after all code run
            // finished in the function, but before the return clause executed
            defer {
                print("defer block called")
                fridgeIsOpen = false
            }

            let result = fridgeContent.contains(food)
            
            print("will return")
            return result
        }
        let result = fridgeContains("banana")
        print("did return")
        print(result)
        print(fridgeIsOpen)
        // Prints "false"
    }
    
    func test_multiple_defer() throws {
        var fridgeIsOpen = false
        let fridgeContent = ["milk", "eggs", "leftovers"]

        func fridgeContains(_ food: String) -> Bool {
            fridgeIsOpen = true
            // Note: use defer mark a code block will be executed after all code run
            // finished in the function, but before the return clause executed
            defer {
                print("defer block called")
                fridgeIsOpen = false
            }
            
            // Note: allow multiple defer block, the follow FILO order
            defer {
                print("another defer block called")
            }

            let result = fridgeContent.contains(food)
            
            print("will return")
            return result
        }
        let result = fridgeContains("banana")
        print("did return")
        print(result)
        print(fridgeIsOpen)
        // Prints "false"
    }
}
