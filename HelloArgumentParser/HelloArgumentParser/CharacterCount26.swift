//
//  CharacterCount26.swift
//  HelloArgumentParser
//
//  Created by wesley_chen on 2022/5/25.
//

import Foundation
import ArgumentParser

struct CharacterCount26: ParsableCommand {
    
    // Input:
    // $ ./CharacterCount26 direct-string "Alice"
    static let configuration = CommandConfiguration(
        commandName: "CharacterCounter",
        abstract: "Allows you to count the number of characters in a string",
        discussion: "A string is a made up of multiple characters. A character can be human-readable or a control character. When counting characters, you may need to know if you want to consider control characters or not, as the results may vary.",
        subcommands: [DirectString.self])
    
    enum CountingConfiguration: EnumerableFlag /*String, CaseIterable*/ {
      case all
      case uppercaseOnly
      case lowercaseOnly
    }
    
    struct Options: ParsableArguments {
        @Flag(help: "The kind of characters to count") var countingConfig: CountingConfiguration = CountingConfiguration.all
      
        @Flag(help: "If set, ignores whitespace characters") var ignoringWhitespace: Bool = false
      
        @Option(help: "Multiplies the end result by the specified number") var multiplier: Int = 1
    }
}

extension CharacterCount26 {
    struct DirectString: ParsableCommand {
        @Argument(help: "The string to count the characters of") var string: String
        
        func run() {
            print(string.count)
        }
    }
}
