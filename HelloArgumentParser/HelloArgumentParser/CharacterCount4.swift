//
//  CharacterCount4.swift
//  HelloArgumentParser
//
//  Created by wesley_chen on 2022/5/25.
//

import Foundation
import ArgumentParser

struct CharacterCount4 : ParsableCommand {
    // Input:
    // $ ./character-count4 Alice
    @Argument(help: "String to count the characters of", transform: ({ return "\($0)makeItLonger" })) var string: String
    
    func run() throws {
        print(string)
        print(string.count)
    }
}
