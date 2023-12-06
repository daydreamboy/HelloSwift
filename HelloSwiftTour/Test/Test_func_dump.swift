//
//  Test_func_dump.swift
//  Test
//
//  Created by wesley_chen on 2023/12/5.
//

import XCTest
import UIKit

final class Test_func_dump: XCTestCase {
    func test_dump() throws {
        // dump string
        dump("This is a string")
        // dump string with a label
        dump("This is a string", name: "test")
        // dump string with a label and indent
        dump("This is a string", name: "test", indent: 4)
        // dump view
        let view = UIView.init(frame: CGRect(x: 1, y: 2, width: 3, height: 4))
        dump(view)
    }
}
