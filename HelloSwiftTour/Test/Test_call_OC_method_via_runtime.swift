//
//  Test_runtime_call_OC_method.swift
//  Test
//
//  Created by wesley_chen on 2023/6/7.
//

import XCTest

final class Test_runtime_call_OC_method: XCTestCase {
    
    func test_runtime_call_OC_method() throws {
        if let classType = NSClassFromString("OCPrivateTool") {
            let cls = classType as! NSObject.Type
            let sel = "doSomethingWithVideoAtPath:completion:"
            
            //let path = "path/to/file"
            let path = ""
            
            if cls.responds(to: Selector(sel)) {
                // Note: use @convention(block) indicates it's an Objective-C block, not swift closure
                // https://stackoverflow.com/questions/55340270/how-to-pass-closure-as-a-parameter-in-performselector-withobject
                let completion: @convention(block) (Bool, NSError) -> Void = { (succes: Bool, error: NSError?) -> Void in
                    print("success: \(succes), error: \(error?.localizedFailureReason ?? "<nil>")")
                }
                
                cls.perform(Selector(sel), with: path, with: completion)
            }
        }
    }
}
