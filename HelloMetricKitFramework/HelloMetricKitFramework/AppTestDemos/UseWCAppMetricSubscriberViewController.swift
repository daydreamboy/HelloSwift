//
//  UseWCAppMetricSubscriberViewController.swift
//  AppTestTemplate
//
//  Created by wesley_chen on 2022/4/24.
//

import UIKit

class UseWCAppMetricSubscriberViewController: UITableViewController {
    var metric: WCAppMetricSubscriber = WCAppMetricSubscriber.init()
    var titles: Array<String>?
    var classes: Array<Any>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.metric.receiveReports()
    }
    
    func prepareForInit() {
        self.title = "Test Exception"
        
        self.titles = [
            "force unwrapped nil value",
        ]
        
        self.classes = [
            "forceUnwrappedNilValue",
        ];
    }
    
    func pushViewController(objectOrClass: Any) {
        if objectOrClass is String {
            let sel: Selector = Selector(objectOrClass as! String) //NSSelectorFromString(objectOrClass as! String)
            if (self.responds(to: sel)) {
                self.perform(sel)
            }
            else {
                assert(false, "can't handle selector \(objectOrClass)")
            }
        }
        else {
            assert(false, "can't handle selector \(objectOrClass)")
        }
    }
    
    // MARK: --
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.prepareForInit()
    }
    
    override init(style: UITableView.Style) {
        super.init(style: style)
        
        self.prepareForInit()
    }
    
    required convenience init?(coder: NSCoder) {
        self.init(style: UITableView.Style.plain)
    }

    // MARK: - UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titles!.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "RootViewController")
        if (cell == nil) {
            cell = UITableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "RootViewController")
            cell!.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        }
        cell!.textLabel?.text = self.titles![indexPath.row]

        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item: Any = self.classes?[indexPath.row] as Any
        self.pushViewController(objectOrClass: item)
    }
    
    // MARK: Test Methods
    
    @objc func forceUnwrappedNilValue() {
        let optionalValue: Int? = nil
        let forceUnwrappedValue = optionalValue!
        print(forceUnwrappedValue)
    }
}

