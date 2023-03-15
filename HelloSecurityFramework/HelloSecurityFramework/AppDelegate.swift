//
//  AppDelegate.swift
//  AppTestTemplate
//
//  Created by wesley_chen on 2022/4/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var rootViewController: RootViewController?
    var navController: UINavigationController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // @see https://sarunw.com/posts/how-to-create-new-xcode-project-without-storyboard/
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.rootViewController = RootViewController.init(style: UITableView.Style.plain)
        self.navController = UINavigationController.init(rootViewController: self.rootViewController!)
        
        window.rootViewController = self.navController
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }
}

