//
//  Test_call_OC_method_via_interface.swift
//  Test
//
//  Created by wesley_chen on 2023/6/9.
//

import XCTest
import OCStaticLibrary

final class Test_call_OC_method_via_interface: XCTestCase {
    func test_call_OC_method_1() throws {
        // Case 1
        WCPublicTool.doSomethingWithImage(atPath: "") { succes, error in
            print("succes: \(succes), error: \(error?.localizedDescription ?? "no error")")
        }
        
        // Case 2
        WCPublicTool.doSomethingWithImage(atPath: "path/to/image") { succes, error in
            print("succes: \(succes), error: \(error?.localizedDescription ?? "no error")")
        }
    }
    
    @available(iOS 13.0.0, *)
    func test_call_OC_method_2() async throws {
        // Case 3
        // Note: the doSomethingWithImage is async function
        // do-catch refer to https://wwdcbysundell.com/2021/wrapping-completion-handlers-into-async-apis/
        do {
            let path = ""
            //let path = "path/to/image"
            let result = try await WCPublicTool.doSomethingWithImage(atPath: path)
            print(result)
        } catch {
            print(error)
        }
    }
}
