//
//  CharacterCount13.swift
//  HelloArgumentParser
//
//  Created by wesley_chen on 2022/5/25.
//

import Foundation
import ArgumentParser

struct CharacterCount13 : ParsableCommand {
    // Input:
    // $ ./character-count3 Alice -m 3
    
    @Argument(help: "String to count the characters of") var string: String
    // Note: now multiplier has a default value 1
    @Option(help: "The number to multiply the count against.") var multiplier: Int = 1
    
    func run() throws {
        print(string.count * multiplier)
    }
}
