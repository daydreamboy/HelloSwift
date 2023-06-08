//
//  MySwiftObject.swift
//  Test
//
//  Created by wesley_chen on 2022/4/28.
//

import UIKit
import Foundation

@objc(MySwiftObject)
class MySwiftObject: NSObject {
    @objc var someProperty: AnyObject = "Some Initialized Value" as NSString

    override init() {}

    @objc func someFunction(someArg: Any) -> NSString {
        return "You sent me \(someArg)" as NSString
    }
    
    func anotherFunction() {
        print("anotherFunction called")
    }
}
