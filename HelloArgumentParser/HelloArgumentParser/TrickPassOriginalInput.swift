//
//  GetOriginalInputString.swift
//  HelloArgumentParser
//
//  Created by wesley_chen on 2022/5/26.
//

import Foundation
import ArgumentParser

struct GetOriginalInputString: ParsableCommand {
    
    // Input:
    // $ ./GetOriginalInputString direct-string --help
    static let configuration = CommandConfiguration(
        commandName: "GetOriginalInputString",
        abstract: "Allows you to count the number of characters in a string",
        discussion: "A string is a made up of multiple characters. A character can be human-readable or a control character. When counting characters, you may need to know if you want to consider control characters or not, as the results may vary.",
        subcommands: [DirectString.self])
}

extension GetOriginalInputString {
    struct DirectString: ParsableCommand {
        @Argument()
        var string: String?
        
        func validate() throws {
            print(string ?? "")
            print(CommandLine.arguments)
            var arguments:[String] = [String]()
            arguments.append(contentsOf: CommandLine.arguments)
            arguments.removeFirst()
            arguments.removeFirst()
            _ = runCommand(command: "surgeon", arguments: arguments)
            GetOriginalInputString.exit()
        }
        
        func runCommand(command: String, arguments: [String]) -> Int32 {
            let task = Process()
            task.launchPath = NSHomeDirectory() + "/8/DGSurgeonPatch/saas/test/v3.0.0/5/" + command
            task.arguments = arguments
            task.launch()
            task.waitUntilExit()
            return task.terminationStatus
        }
    }
}



