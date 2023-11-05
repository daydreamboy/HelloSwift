//
//  AliasTool.swift
//  alias_tool
//
//  Created by wesley_chen on 2023/11/5.
//

import Foundation
import ArgumentParser

let version = "1.0"

let timestamp: String = currentFileTimestamp()
let versionString: String = "\(version) (build time: \(timestamp))"

/**
 A tool can convert alias path into real path
 
 @see https://github.com/rptb1/aliasPath/blob/master/aliasPath.m
 */
struct AliasTool : ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "alias_tool",
        abstract: "Convert MacOS alias path into real path",
        discussion: "If convert successfully, output is a real path with status code(0), or the input path if failed",
        version: versionString)
    
    @Argument(help: "The alias path to file or folder") var aliasPath: String
    @Flag(help: "If set, print debug info") var debug: Bool = false
    
    mutating func run() throws {
        do {
            // @see https://stackoverflow.com/a/51190988
            aliasPath = aliasPath.replacingOccurrences(of: "~", with: FileManager.default.homeDirectoryForCurrentUser.path)
            let fileURL = URL.init(fileURLWithPath: aliasPath)
            let bookmarkData = try URL.bookmarkData(withContentsOf: fileURL)
            let values = URL.resourceValues(forKeys: [ .pathKey ], fromBookmarkData: bookmarkData)
            if let path = values?.path {
                print(path)
            }
            else {
                if debug {
                    print("[Debug] not find key `pathKey` in bookmarkData")
                }
            }
        } catch {
            if debug {
                print("[Debug] \(error)")
            }
            
            print(aliasPath)
        }
    }
}

fileprivate func currentFileTimestamp() -> String {
    do {
        let fileAttributes = try FileManager.default.attributesOfItem(atPath: #file)
        if let modificationDate = fileAttributes[.modificationDate] as? Date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let formattedDate = dateFormatter.string(from: modificationDate)
            return formattedDate
        }
    } catch {
    }
    return "Unkown time"
}

