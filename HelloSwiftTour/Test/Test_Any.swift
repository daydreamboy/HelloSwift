//
//  Test_Any.swift
//  Test
//
//  Created by wesley_chen on 2023/11/14.
//

import XCTest

final class Test_Any: XCTestCase {
    func test_use_as_generic_type() throws {
        let arrayOfAny: [Any] = [
            0,
            "string",
            { (message: String) -> Void in print(message) },
            String.self
        ]
        print(arrayOfAny)
    }
}
