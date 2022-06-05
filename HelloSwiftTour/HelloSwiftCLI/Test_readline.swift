//
//  Test_readline.swift
//  HelloSwiftCLI
//
//  Created by wesley_chen on 2022/6/3.
//

import Foundation

// example from https://www.hackingwithswift.com/example-code/system/how-do-you-read-from-the-command-line
func readline_only_one_line() -> Void {
    print("Please enter your name:")

    // Note: readline will return when the following two cases:
    // 1. read input encounter the end of line (carriage return)
    // 2. receive EOF signal (Crtl+D)
    
    // Test Case:
    // a. input some text, and press Return. Get the text to the `name`
    // b. input nothing, and press Return.  Get the empty string to the `name`
    // c. input some text, and press Crtl+D. Get the text to the `name`
    //
    if let name = readLine() {
        print("Hello, \(name)!")
    } else {
        print("Why are you being so coy?")
    }

    print("TTFN!")
}
