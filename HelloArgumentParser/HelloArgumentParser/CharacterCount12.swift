//
//  CharacterCount12.swift
//  HelloArgumentParser
//
//  Created by wesley_chen on 2022/5/25.
//

import Foundation
import ArgumentParser

struct CharacterCount12 : ParsableCommand {
    // Input:
    // $ ./character-count3 Alice -m 3
    
    @Argument(help: "String to count the characters of") var string: String
    // Note: use @Option to receive the option
    @Option(
        name: [
        .customLong("multiplier"),
        .customLong("multi"),
        .customLong("mult"),
        .customLong("multiplicador"),
        .customLong("multiplierr")],
      help: "The number to multiply the count against.") var multiplier: Int
    
    func run() throws {
        print(string.count * multiplier)
    }
}
