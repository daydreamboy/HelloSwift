//
//  CharacterCount2.swift
//  HelloArgumentParser
//
//  Created by wesley_chen on 2022/5/25.
//

import Foundation
import ArgumentParser

struct CharacterCount2 : ParsableCommand {
    // Input:
    // $ ./character-count2 "Alice Bob"
    @Argument(help: "Strings to count the characters of") var strings: [String]
    
    func run() throws {
        strings.forEach { print($0.count) }
    }
}
