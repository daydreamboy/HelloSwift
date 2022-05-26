//
//  CharacterCount23.swift
//  HelloArgumentParser
//
//  Created by wesley_chen on 2022/5/25.
//

import Foundation
import ArgumentParser

struct CharacterCount23: ParsableCommand {
    
    // Input:
    // $ ./CharacterCount23 direct-string "Pullip Classical Alice"
    // $ ./CharacterCount23 direct-string "Pullip Classical Alice" --ignoring-whitespace
    // $ ./CharacterCount23 direct-string "Pullip Classical Alice" --ignoring-whitespace --multiplier 3
    static let configuration = CommandConfiguration(subcommands: [DirectString.self])
  
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

extension CharacterCount23 {
    struct DirectString: ParsableCommand {
        @Argument(help: "The string to count the characters of") var string: String
        
        @OptionGroup() var parentOptions: Options
        
        func run() {
            let whiteSpacechars = string.filter { $0 == " " }.count
            let alwaysSubtract = parentOptions.ignoringWhitespace ? whiteSpacechars : 0
            let mult = parentOptions.multiplier
            
            if parentOptions.countingConfig == .all {
                print((string.count - alwaysSubtract) * mult)
            }
            
            if parentOptions.countingConfig == .uppercaseOnly {
                let count = string.filter { $0.isUppercase }.count
                print((count - alwaysSubtract) * mult)
            }
            
            if parentOptions.countingConfig == .lowercaseOnly {
                let count = string.filter { $0.isLowercase }.count
                print((count - alwaysSubtract) * mult)
            }
        }
    }
}
