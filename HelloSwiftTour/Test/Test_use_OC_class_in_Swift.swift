//
//  Test_use_OC_class_in_Swift.swift
//  Test
//
//  Created by wesley_chen on 2022/4/28.
//

import XCTest

// example: https://stackoverflow.com/a/24005242
class Test_use_OC_class_in_Swift: XCTestCase {

    func test_WCSecurityTool_aes256Decrypt() throws {
        var inputString: String;
        var outputString: String?;
        var data: Data?
        var encryptedData: Data?
        var decryptedData: Data?
        
        // Case 1
        inputString = "Hello, world!"
        data = inputString.data(using: String.Encoding.utf8)
        encryptedData = WCSecurityTool.aes256Encrypt(with: data!, key: "123")
        decryptedData = WCSecurityTool.aes256Decrypt(with: encryptedData!, key: "123")
        outputString = String.init(data: decryptedData!, encoding: String.Encoding.utf8)
        
        XCTAssertEqual(outputString, inputString)
    }
}
