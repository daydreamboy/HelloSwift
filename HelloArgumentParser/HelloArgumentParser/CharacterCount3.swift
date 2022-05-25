//
//  CharacterCount3.swift
//  HelloArgumentParser
//
//  Created by wesley_chen on 2022/5/25.
//

import Foundation
import ArgumentParser

struct CharacterCount3 : ParsableCommand {
    // Input:
    // $ ./character-count3 Alice 4
    @Argument(help: "String to count the characters of") var string: String
    @Argument(help: "Multiplier") var multiplier: Int
    
    func run() throws {
        print(string.count * multiplier)
    }
}
