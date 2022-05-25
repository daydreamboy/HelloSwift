//
//  CharacterCount15.swift
//  HelloArgumentParser
//
//  Created by wesley_chen on 2022/5/25.
//

import Foundation
import ArgumentParser

struct CharacterCount15 : ParsableCommand {
    // Input:
    // $ ./character-count3 "Pullip Classical Alice" --ignoring-white-space
    
    @Argument(help: "String to count the characters of") var string: String
    
    @Flag(help: "When set, it ignores whitespace characters") var ignoringWhiteSpace: Bool = false
    // Note: error when not set initial value
    //@Flag(help: "When set, it ignores whitespace characters") var ignoringWhiteSpace: Bool
    
    func run() throws {
        print(ignoringWhiteSpace ? string.filter { $0 != " " }.count : string.count)
    }
}
