//
//  ViewController.swift
//  AppTestTemplate
//
//  Created by wesley_chen on 2022/4/24.
//

import UIKit

class ViewController: UIViewController {
    var metric: WCAppMetricSubscriber = WCAppMetricSubscriber.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.metric.receiveReports()
    }
}

