//
//  RootViewController.swift
//  AppTestTemplate
//
//  Created by wesley_chen on 2022/4/25.
//

import UIKit

class RootViewController: UITableViewController {
    
    var titles: Array<String>?
    var classes: Array<Any>?
    
    func prepareForInit() {
        self.title = "AppTest"
        
        self.titles = [
            "Use WCAppMetricSubscriber",
            "Issues",
            "call a test method",
        ]
        
        self.classes = [
            UseWCAppMetricSubscriberViewController.self,
            IssueRemoveSubscriberCauseCrashViewController.self,
            "testMethod",
        ];
        
        //let sel = #selector(RootViewController.testMethod)
        
//        let sel: Selector = Selector("testMethod") //NSSelectorFromString(objectOrClass as! String)
//        if (self.responds(to: sel)) {
//            self.perform(sel)
//        }
    }
    
    func pushViewController(objectOrClass: Any) {
        // Runtime Error:
        /*
        let object: NSObject = objectOrClass as! NSObject
        let clz: AnyClass = objectOrClass as! AnyClass
         */
        
        // @see https://stackoverflow.com/a/24220444 // https://stackoverflow.com/questions/40388337/swift-3-how-to-verify-class-type-of-object
        if objectOrClass is String {
            let sel: Selector = Selector(objectOrClass as! String) //NSSelectorFromString(objectOrClass as! String)
            if (self.responds(to: sel)) {
                self.perform(sel)
            }
            else {
                assert(false, "can't handle selector \(objectOrClass)")
            }
        }
        else if (objectOrClass is AnyClass) {
            let clz: AnyClass = objectOrClass as! AnyClass
            
            if (clz.isSubclass(of: UIViewController.self)) {
                // @see https://stackoverflow.com/a/32410277
                let viewControllerClass: UIViewController.Type = clz as! UIViewController.Type
                let viewController = viewControllerClass.init(nibName: nil, bundle: nil)
                let index = self.classes?.firstIndex(where: { $0 as! AnyClass === clz })
                viewController.title = self.titles![index!]
                
                self.navigationController?.navigationItem.backBarButtonItem = UIBarButtonItem.init(title: "a", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        }
    }
    
    // MARK: --
    
    override init(style: UITableView.Style) {
        super.init(style: style)
        
        self.prepareForInit()
    }
    
    required convenience init?(coder: NSCoder) {
        self.init(style: UITableView.Style.plain)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
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
    
    // @see https://stackoverflow.com/a/46545602
    @objc func testMethod() {
        NSLog("test something")
    }
}
