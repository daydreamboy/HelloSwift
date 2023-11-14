//
//  Test_AnyObject.swift
//  Test
//
//  Created by wesley_chen on 2023/11/8.
//

import XCTest

class IntegerRef {
    let value: Int
    init(_ value: Int) {
        self.value = value
    }

    @objc func getIntegerValue() -> Int {
        return value
    }
}

// Note: define another class, cheat compiler there is a method getIntegerValue2 for IntegerRef,
// not for IntegerRef2
class IntegerRef2 {
    let value: Int
    init(_ value: Int) {
        self.value = value
    }

    @objc func getIntegerValue2() -> Int {
        return value
    }
}

func getObject() -> AnyObject {
    return IntegerRef(100)
}

final class Test_AnyObject: XCTestCase {
    func test_concrete_object_convert_to_AnyObject_type() throws {
        let s: AnyObject = "This is a bridged string." as NSString
        let v: AnyObject = 100 as NSNumber
        
        let mixedArray: [AnyObject] = [s, v]
        for object in mixedArray {
            switch object {
            case let x as String:
                print("'\(x)' is a String")
            default:
                print("'\(object)' is not a String")
            }
        }
    }
    
    func test_dynamic_dispatch_with_objc_method() throws {
        let obj: AnyObject = getObject()
        let possibleValue = obj.getIntegerValue?()
        print(possibleValue as Any) // Prints "Optional(100)"
         
        let certainValue = obj.getIntegerValue()
        print(certainValue) // Prints "100"
    }
    
    func test_issue1_dynamic_dispatch_with_objc_method() throws {
        let obj: AnyObject = getObject()
        let possibleValue = obj.getIntegerValue2?() // Ok, obj as IntegerRef type, has no getIntegerValue2 method, get a nil
        print(possibleValue as Any) // Prints nil

        let certainValue = obj.getIntegerValue2() // Crash: obj as IntegerRef type, has no getIntegerValue2 method, not found getIntegerValue2 method
        print(certainValue) // Prints "100"
    }
    
    func test_issue1_fixed_dynamic_dispatch_with_objc_method() throws {
        let obj: AnyObject = getObject()
        if let f = obj.getIntegerValue {
            print("The value of 'obj' is \(f())")
        } else {
            print("'obj' does not have a 'getIntegerValue()' method")
        }
        // Prints "The value of 'obj' is 100"
        
        // Style1: do optional bind for methods, then call f() safely
        if let f = obj.getIntegerValue2 {
            print("The value of 'obj' is \(f())")
        } else {
            print("'obj' does not have a 'getIntegerValue()' method")
        }
        // Prints "'obj' does not have a 'getIntegerValue()' method"
        
        // Style2: use optional methods
        let possibleValue = obj.getIntegerValue2?() // Ok, obj as IntegerRef type, has no getIntegerValue2 method, get a nil
        print(possibleValue as Any) // Prints nil
    }
}
