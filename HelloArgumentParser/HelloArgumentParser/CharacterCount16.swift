//
//  CharacterCount16.swift
//  HelloArgumentParser
//
//  Created by wesley_chen on 2022/5/25.
//

import Foundation
import ArgumentParser

struct CharacterCount16 : ParsableCommand {
    // Input:
    // $ ./character-count3 "Pullip Classical Alice" --ignoring-white-space
    
    @Argument(help: "String to count the characters of") var string: String
    
    @Flag(name: .short, help: "When set, it ignores whitespace characters") var ignoringWhiteSpace: Bool = false

    func run() throws {
        print(ignoringWhiteSpace ? string.filter { $0 != " " }.count : string.count)
    }
}
