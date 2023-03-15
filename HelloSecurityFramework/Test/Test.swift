//
//  Test.swift
//  Test
//
//  Created by wesley_chen on 2022/4/26.
//

import XCTest

class Test: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let filePath = Bundle.init(for: type(of: self)).path(forResource: "1", ofType: "txt")
        let fileURL = URL.init(fileURLWithPath: filePath!)
        let data = try Data.init(contentsOf: fileURL)
        let encrptedData = WCSecurityTool.encryptionAESModeECB(messageData: data, key: "123")
        print(encrptedData!)
        
        let encrptedData2 = WCSecurityTool.encryptionAESModeECB(messageData: data, key: "123")
        print(encrptedData2!)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
