//
//  CharacterCount5.swift
//  HelloArgumentParser
//
//  Created by wesley_chen on 2022/5/25.
//

import Foundation
import ArgumentParser

struct CharacterCount5 : ParsableCommand {
    // Input:
    // $ ./character-count5 https://www.baidu.com/
    @Argument(help: "URL to retrieve", transform: ({ return URL(string: $0)!})) var string: URL
    
    func run() throws {
        print(string)
    }
}
