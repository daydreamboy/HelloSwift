//
//  CharacterCount14.swift
//  HelloArgumentParser
//
//  Created by wesley_chen on 2022/5/25.
//

import Foundation
import ArgumentParser

struct CharacterCount14 : ParsableCommand {
    // Input:
    // $ ./character-count3 Alice --multiplier 3
    
    @Argument(help: "String to count the characters of") var string: String
    @Option(
      help: "The number to multiply the count against.",
      transform: ({ Int($0)! == 0 ? 1 : Int($0)! })) var multiplier: Int
    
    func run() throws {
        print(string.count * multiplier)
    }
}
