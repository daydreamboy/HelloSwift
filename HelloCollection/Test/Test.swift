//
//  Test.swift
//  Test
//
//  Created by wesley_chen on 2023/6/11.
//

import XCTest

final class Test: XCTestCase {

    func test_subscript_safe() throws {
        let streets = ["Adams", "Bryant", "Channing", "Douglas", "Evarts"]
        var index = 5
        let boo = streets[safe: index]
        XCTAssertNil(boo)

        index = 6
        guard streets[safe: index] != nil else {
            return
        }
    }
}
