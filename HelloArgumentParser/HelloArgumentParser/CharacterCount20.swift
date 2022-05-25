//
//  CharacterCount20.swift
//  HelloArgumentParser
//
//  Created by wesley_chen on 2022/5/25.
//

import Foundation
import ArgumentParser

struct CharacterCount20 : ParsableCommand {
    // Input:
    // $ ./character-count3 "hi"
    
    @Argument(help: "File to count the characters of") var filePath: String
    
    func run() throws {
        let contents = try String(contentsOfFile: filePath, encoding: .utf8)
        print(contents.count)
    }
}
