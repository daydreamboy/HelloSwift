//
//  CharacterCount22.swift
//  HelloArgumentParser
//
//  Created by wesley_chen on 2022/5/25.
//

import Foundation
import ArgumentParser

struct CharacterCount22: ParsableCommand {
    
    // Input:
    // $ ./CharacterCount22 direct-string "Alice"
    static let configuration = CommandConfiguration(subcommands: [DirectString.self])
  
    // Note: use EnumerableFlag instead of String, CaseIterable
    // https://apple.github.io/swift-argument-parser/documentation/argumentparser/flag
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

extension CharacterCount22 {
    struct DirectString: ParsableCommand {
        @Argument(help: "The string to count the characters of") var string: String
        
        func run() {
            print(string.count)
        }
    }
}
