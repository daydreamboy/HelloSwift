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
        NSLog("%@ called", #function)
    }
}
