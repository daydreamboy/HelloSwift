//
//  Test_property_stored.swift
//  Test
//
//  Created by wesley_chen on 2024/11/17.
//

import XCTest
import UIKit

final class Test_property_stored: XCTestCase {
    // Note: This stored property called twice which maybe a bug in XCTest,
    // but in ViewController, this stored property called only once
    private var myView1: UIView = {
        var view = UIView.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        NSLog("create view1: \(view)")
        return view
    }()

    func test_use_stored_property() throws {
        NSLog("test_use_stored_property called")
        // Note: each call self.myView1 will call stored property
        let _ = self.myView1
    }
}
