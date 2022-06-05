//
//  runCommandByCode.swift
//  HelloArgumentParser
//
//  Created by wesley_chen on 2022/6/3.
//

import Foundation

class runCommandByCode {
    
    // Note: build ComposableCommand, and move executable to Test folder, then build this file to test
    func main() -> Void {
        runCommand(command: "HelloArgumentParser", arguments: [])
    }
    
    @discardableResult
    func runCommand(command: String, arguments: [String]) -> Int32 {
        let task = Process()
        task.launchPath = NSHomeDirectory() + "/Library/Developer/Xcode/DerivedData/HelloArgumentParser-dohtqmhqkcxijjaboocezrupfzta/Build/Products/Debug/Test/" + command
        task.arguments = arguments
        task.launch()
        task.waitUntilExit()
        return task.terminationStatus
    }

}
