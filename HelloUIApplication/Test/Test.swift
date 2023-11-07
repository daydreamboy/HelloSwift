//
//  Test.swift
//  Test
//
//  Created by wesley_chen on 2023/11/7.
//

import XCTest

final class Test: XCTestCase {

    func test_() throws {
        let pathURL = WCApplicationTool.appDocumentsDirectory()
        NSLog(pathURL.path)
    }

}
