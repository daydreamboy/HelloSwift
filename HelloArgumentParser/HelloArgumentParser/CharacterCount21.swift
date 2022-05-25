//
//  CharacterCount21.swift
//  HelloArgumentParser
//
//  Created by wesley_chen on 2022/5/25.
//

import Foundation
import ArgumentParser

struct CharacterCount21 : ParsableCommand {
    // Input:
    // $ ./character-count3 "hi"
    
    @Argument(help: "File to count the characters of") var filePath: String
    
    mutating func validate() throws {
        if !FileManager.default.fileExists(atPath: filePath) {
            throw ValidationError("'filePath' does not exist")
        }
    }
    
    func run() throws {
        let contents = try String(contentsOfFile: filePath, encoding: .utf8)
        print(contents.count)
    }
}
