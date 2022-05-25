//
//  Math.swift
//  HelloArgumentParser
//
//  Created by wesley_chen on 2022/5/25.
//

import Foundation
import ArgumentParser

struct Math: ParsableCommand {
    // Input:
    // $ ./math --add
    enum Operation: EnumerableFlag {
        case add
        case multiply
    }

    @Flag var operation: Operation

    mutating func run() {
        print("Time to \(operation)!")
    }
}
