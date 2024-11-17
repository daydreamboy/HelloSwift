//
//  UseComputedPropertyViewController.swift
//  HelloSwiftTour
//
//  Created by wesley_chen on 2024/11/17.
//

import UIKit

class UseComputedPropertyViewController: UIViewController {
    private var myView1: UIView {
        var view = UIView.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        NSLog("create view1: \(view)")
        return view
    }
    
    override func viewDidLoad() {
        NSLog("viewDidLoad called")
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        let _ = self.myView1
        self.view.addSubview(self.myView1)
    }
}
