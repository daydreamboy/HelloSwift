//
//  CharacterCount7.swift
//  HelloArgumentParser
//
//  Created by wesley_chen on 2022/5/25.
//

import Foundation
import ArgumentParser

struct CharacterCount7 : ParsableCommand {
    // Input:
    // $ ./character-count3 Alice -m 3
    
    // Wrong Input:
    // Alice --multiplier 4
    @Argument(help: "String to count the characters of") var string: String
    // Note: use @Option to receive the option
    @Option(name: .short, help: "The number to multiply the count against.") var multiplier: Int
    
    func run() throws {
        print(string.count * multiplier)
    }
}
