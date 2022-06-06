//
//  main.swift
//  HelloCLI
//
//  Created by wesley_chen on 2022/6/6.
//

import Foundation
import AppKit

// @see https://stackoverflow.com/a/39926740
extension NSImage {
    var pngData: Data? {
        guard let tiffRepresentation = tiffRepresentation, let bitmapImage = NSBitmapImageRep(data: tiffRepresentation) else { return nil }
        return bitmapImage.representation(using: .png, properties: [:])
    }
    
    func pngWrite(to url: URL, options: Data.WritingOptions = .atomic) -> Bool {
        do {
            try pngData?.write(to: url, options: options)
            return true
        } catch {
            print(error)
            return false
        }
    }
}

func runCommand(command: String, arguments: [String]) -> Int32 {
    let task = Process()
    task.launchPath = "/usr/bin/" + command
    task.arguments = arguments
    task.launch()
    task.waitUntilExit()
    return task.terminationStatus
}

let image = WCCoreImageTool.QRImage("Hello, world!", NSMakeSize(250, 250), NSColor.green)
print(image as Any)

var filePath = URL.init(fileURLWithPath: FileManager.default.currentDirectoryPath)
filePath.appendPathComponent(UUID.init().uuidString)
filePath.appendPathExtension("png")
if let image = image {
    _ = image.pngWrite(to: filePath)
    _ = runCommand(command: "open", arguments: ["/System/Applications/Preview.app", filePath.path])
}
