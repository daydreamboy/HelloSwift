//
//  CharacterCount24.swift
//  HelloArgumentParser
//
//  Created by wesley_chen on 2022/5/25.
//

import Foundation
import ArgumentParser

struct CharacterCount24: ParsableCommand {
    
    // Input:
    // $ ./CharacterCount24 direct-string "Pullip Classical Alice"
    // $ ./CharacterCount24 direct-string "Pullip Classical Alice" --ignoring-whitespace
    // $ ./CharacterCount24 direct-string "Pullip Classical Alice" --ignoring-whitespace --multiplier 3
    static let configuration = CommandConfiguration(
        subcommands: [
          DirectString.self,
          RemoteFile.self,
          LocalFile.self
        ]
    )
  
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

extension CharacterCount24 {
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

extension CharacterCount24 {
  struct LocalFile: ParsableCommand {
    @Argument(help: "A path to a local file to count the characters of") var localFile: String
    
    @OptionGroup() var parentOptions: Options
    
    func run() {
      do {
        let string = try String(contentsOfFile: localFile)
        processString(string: string, options: parentOptions)
      } catch {
        print("Unable to open local file")
      }
    }
  }
}

extension CharacterCount24 {
  struct RemoteFile: ParsableCommand {
    @Argument(help: "The URL of the remote file to count the characters of", transform: { URL(string: $0)! }) var remoteFile: URL
    
    @OptionGroup() var parentOptions: Options
    
    func run() {
      do {
        let string = try String(contentsOf: remoteFile)
        processString(string: string, options: parentOptions)
      } catch {
        print("Unable to open local file")
      }
    }
  }
}

func processString(string: String, options: CharacterCount24.Options) {
  let whiteSpacechars = string.filter { $0 == " " }.count
  let alwaysSubstract = options.ignoringWhitespace ? whiteSpacechars : 0
  let mult = options.multiplier
  
  if options.countingConfig == .all {
    print((string.count - alwaysSubstract) * mult)
  }
  
  if options.countingConfig == .uppercaseOnly {
    let count = string.filter { $0.isUppercase }.count
    print((count - alwaysSubstract) * mult)
  }
  
  if options.countingConfig == .lowercaseOnly {
    let count = string.filter { $0.isLowercase }.count
    print((count - alwaysSubstract) * mult)
  }
}
