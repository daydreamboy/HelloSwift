//
//  CharacterCount19.swift
//  HelloArgumentParser
//
//  Created by wesley_chen on 2022/5/25.
//

import Foundation
import ArgumentParser

struct CharacterCount19 : ParsableCommand {
    // Input:
    // $ ./character-count3 "hi"
    
    @Argument(help: "String to count the characters of") var string: String
    
    mutating func validate() throws {
        if string.count < 3 {
            throw ValidationError("'string' must contain at least 3 characters.")
        }
    }
    
    func run() {
        print(string.count)
    }
}
