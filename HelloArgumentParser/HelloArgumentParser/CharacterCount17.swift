//
//  CharacterCount17.swift
//  HelloArgumentParser
//
//  Created by wesley_chen on 2022/5/25.
//

import Foundation
import ArgumentParser

struct CharacterCount17 : ParsableCommand {
    // Input:
    // $ ./character-count3 "Pullip Classical Alice" --ignoring-white-space
    
    @Argument(help: "String to count the characters of") var string: String
    
    // Note: .prefixedEnableDisable to enable prefix '--enable-xxx' or '--disable-xxx'
    @Flag(inversion: .prefixedEnableDisable, help: "When set, it ignores whitespace characters")
    var ignoringWhiteSpace: Bool = false

    func run() throws {
        print(ignoringWhiteSpace ? string.filter { $0 != " " }.count : string.count)
    }
}
