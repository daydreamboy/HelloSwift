//
//  CharacterCount.swift
//  HelloArgumentParser
//
//  Created by wesley_chen on 2022/5/25.
//

import Foundation
import ArgumentParser

struct CharacterCount : ParsableCommand {
    // Input:
    // Alice
    // Alice Bob
    
    @Argument(help: "String to count the characters of") var string: String
    // Note: use optional variable to mark the argument is optional
    @Argument(help: "A second string to count the characters of") var string2: String?
    
    func run() throws {
        print(string.count)
        
        if let str2 = string2 {
            print(str2.count)
        }
    }
}

