//
//  ComposableCommand.swift
//  HelloArgumentParser
//
//  Created by wesley_chen on 2022/6/3.
//

import Foundation
import ArgumentParser

// example from https://rderik.com/blog/understanding-the-swift-argument-parser-and-working-with-stdin/#working-with-stdin
struct Colorico: ParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: "Colorico adds colour to text using Console Escape Sequences",
        version: "1.0.0"
    )
    
    enum Colour: Int {
        case red = 31
        case green = 32
    }
    
    @Argument(help: "text to colour.")
    var text: String

    @Flag(inversion: .prefixedNo)
    var good = true

    @Option(name: [.customShort("o"), .long], help: "name of output file(the command only writes to current directory)")
    var outputFile: String?
    
    func run() throws {
        var colour = Colour.green.rawValue
        if !good {
            colour = Colour.red.rawValue
        }
        let colouredText = "\u{1B}[\(colour)m\(text)\u{1B}[0m"
        if let outputFile = outputFile {
            let path = FileManager.default.currentDirectoryPath

            //Lets prevent any directory traversal
            let filename = URL(fileURLWithPath: outputFile).lastPathComponent
            let fullFilename = URL(fileURLWithPath: path).appendingPathComponent(filename)
            try colouredText.write(to: fullFilename, atomically: true, encoding: String.Encoding.utf8)
        } else {
            print(colouredText)
        }
    }
}

func readSTDIN () -> String? {
    var input: String?

    // Note: press Crtl+D to make readLine() to return nil and finish the while loop
    while let line = readLine() {
        if input == nil {
            input = line
        } else {
            // Note: readline's parameter strippingNewline is true by default,
            // so add a newline character manually
            input! += "\n" + line
        }
    }

    return input
}

class ComposableCommand {
    var text: String?
    
    func main() -> Void {
        if CommandLine.arguments.count == 1 || CommandLine.arguments.last == "-" {
            if CommandLine.arguments.last == "-" { CommandLine.arguments.removeLast() }
            text = readSTDIN()
        }

        var arguments = Array(CommandLine.arguments.dropFirst())
        if let text = text {
            arguments.insert(text, at: 0)
        }

        let command = Colorico.parseOrExit(arguments)
        do {
            try command.run()
        } catch {

            Colorico.exit(withError: error)
        }
    }
}
