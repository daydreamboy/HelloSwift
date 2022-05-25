//
//  CharacterCount18.swift
//  HelloArgumentParser
//
//  Created by wesley_chen on 2022/5/25.
//

import Foundation
import ArgumentParser

struct CharacterCount18 : ParsableCommand {
    // Input:
    // $ ./character-count3 "Pullip Al1ce" --whitespace --numbers
    
    // Note: use EnumerableFlag instead of String, CaseIterable
    // https://apple.github.io/swift-argument-parser/documentation/argumentparser/flag
    enum CharSet: EnumerableFlag /*String, CaseIterable*/ {
      case whitespace
      case numbers
      case vowels
    }
    
    @Argument(help: "String to count the characters of") var string: String
    @Flag(help: "Character sets to ignore") var characterSets: [CharSet]
    
    func run() throws {
        var allChars = [String]()
        if characterSets.contains(.whitespace) {
          string.forEach { if $0 == " " { allChars += [String($0)] } }
        }
        
        if characterSets.contains(.numbers) {
          let numbers = (0...9).map { "\($0)" }
          string.forEach { if numbers.contains(String($0)) { allChars += [String($0)] } }
        }
        
        if characterSets.contains(.vowels) {
          let vowels = ["a", "e", "i", "o", "u"]
          string.forEach { if vowels.contains(String($0.lowercased())) { allChars += [String($0)] } }
        }
        
        print(allChars.count)
    }
}
