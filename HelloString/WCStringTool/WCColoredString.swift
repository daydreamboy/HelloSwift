//
//  WCColoredString.swift
//  HelloString
//
//  Created by wesley_chen on 2022/5/26.
//

import Foundation

// @see https://stackoverflow.com/a/56547535
enum ANSIColor: String {

    typealias This = ANSIColor

    case black = "\u{001B}[0;30m"
    case red = "\u{001B}[0;31m"
    case green = "\u{001B}[0;32m"
    case yellow = "\u{001B}[0;33m"
    case blue = "\u{001B}[0;34m"
    case magenta = "\u{001B}[0;35m"
    case cyan = "\u{001B}[0;36m"
    case white = "\u{001B}[0;37m"
    case `default` = "\u{001B}[0;0m"

    static var values: [This] {
        return [.black, .red, .green, .yellow, .blue, .magenta, .cyan, .white, .default]
    }

    static var names: [This: String] = {
        return [
            .black: "black",
            .red: "red",
            .green: "green",
            .yellow: "yellow",
            .blue: "blue",
            .magenta: "magenta",
            .cyan: "cyan",
            .white: "white",
            .default: "default",
        ]
    }()

    var name: String {
        return This.names[self] ?? "unknown"
    }

    static func + (lhs: This, rhs: String) -> String {
        return lhs.rawValue + rhs
    }

    static func + (lhs: String, rhs: This) -> String {
        return lhs + rhs.rawValue
    }

}


extension String {

    func colored(_ color: ANSIColor) -> String {
        if isDebuggerAttached() {
            return self
        }
        else {
            return color + self + ANSIColor.default
        }
    }

    var black: String {
        return colored(.black)
    }

    var red: String {
        return colored(.red)
    }

    var green: String {
        return colored(.green)
    }

    var yellow: String {
        return colored(.yellow)
    }

    var blue: String {
        return colored(.blue)
    }

    var magenta: String {
        return colored(.magenta)
    }

    var cyan: String {
        return colored(.cyan)
    }

    var white: String {
        return colored(.white)
    }

}

// @see https://stackoverflow.com/questions/33177182/detect-if-swift-app-is-being-run-from-xcode
func isDebuggerAttached() -> Bool {
    // Buffer for "sysctl(...)" call's result.
    var info = kinfo_proc()
    // Counts buffer's size in bytes (like C/C++'s `sizeof`).
    var size = MemoryLayout.stride(ofValue: info)
    // Tells we want info about own process.
    var mib : [Int32] = [CTL_KERN, KERN_PROC, KERN_PROC_PID, getpid()]
    // Call the API (and assert success).
    let junk = sysctl(&mib, UInt32(mib.count), &info, &size, nil, 0)
    //assert(junk == 0, "sysctl failed")
    if (junk != 0) {
        return false
    }
    
    // Finally, checks if debugger's flag is present yet.
    return (info.kp_proc.p_flag & P_TRACED) != 0
}
