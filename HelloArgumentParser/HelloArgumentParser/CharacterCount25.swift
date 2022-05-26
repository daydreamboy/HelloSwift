//
//  CharacterCount25.swift
//  HelloArgumentParser
//
//  Created by wesley_chen on 2022/5/25.
//

import Foundation
import ArgumentParser

struct CharacterCount25 : ParsableCommand {
    // Input:
    // $ ./character-count3 "hi"
    
    @Argument(help:
        ArgumentHelp(
          "The string parameter will be counted against the specified character sets",
          discussion: "This obligatory parameter will be used to count the characters of.",
          valueName: "theString",
          visibility: .default)) var string: String
    
    mutating func validate() throws {
        if string.count < 3 {
            throw ValidationError("'string' must contain at least 3 characters.")
        }
    }
    
    func run() {
        print(string.count)
    }
}
