//
//  SWPublicTool.swift
//  SWStaticLibrary
//
//  Created by wesley_chen on 2023/6/9.
//

import Foundation

public class SWPublicTool {
    public static func doSomething(videoPath: String, completion: @escaping (Bool, Error) -> Void) -> Void {
        //print("\(#function) called")
        NSLog("SWPublicTool: %@ called", #function)
    }
}

// Step1: swift class must inherits from NSObject to expose the class to OC
public class SWPublicToolForOC: NSObject {
    
    // Step2: use @objc to mark properties or functions to expose to OC
    @objc
    public static func doSomething(videoPath: String, completion: @escaping (Bool, Error) -> Void) -> Void {
        //print("\(#function) called")
        NSLog("SWPublicToolForOC: %@ called", #function)
    }
}
