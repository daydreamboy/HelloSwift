//
//  Test_property_lazy.swift
//  Test
//
//  Created by wesley_chen on 2024/11/17.
//

import XCTest
import UIKit

final class Test_property_lazy: XCTestCase {
    private var myView1: UIView = {
        var view = UIView.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        NSLog("create view1: \(view)")
        return view
    }()
    
    private var myView2: UIView {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        NSLog("create view2: \(view)")
        return view
    }
    
    // Note: lazy property
    private lazy var myView3: UIView = {
        var view = UIView.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        NSLog("create view3: \(view)")
        return view
    }()

    func test_lazy_stored_property() throws {
        // Case1: non-lazy property, each call will create new property
        let _ = self.myView1
        let _ = self.myView1
        NSLog("----------")
        
        // Case2: non-lazy property, each call will create new property
        let _ = self.myView2
        let _ = self.myView2
        NSLog("----------")
        
        // Case3: lazy property, only firstly call will create new property
        let _ = self.myView3
        let _ = self.myView3
    }
}
