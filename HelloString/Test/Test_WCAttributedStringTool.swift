//
//  Test_WCAttributedStringTool.swift
//  Test
//
//  Created by wesley_chen on 2022/7/2.
//

import XCTest

class Test_WCAttributedStringTool: XCTestCase {
    func test_replaceCharactersInRangesWithString() throws {
        var inputString: NSAttributedString
        var ranges: [NSRange]
        var replacements: [NSAttributedString]
        var outputString: NSAttributedString?
        var replacementRanges: [NSRange]?  = []
        
        // Case 1
        if replacementRanges != nil {
            replacementRanges!.removeAll()
        }
        inputString = NSAttributedString.init(string: "0123456789")
        ranges = [
            NSMakeRange(0, 1),
            NSMakeRange(1, 1),
            NSMakeRange(2, 1),
            NSMakeRange(3, 1),
            NSMakeRange(4, 1),
            NSMakeRange(5, 1),
            NSMakeRange(6, 1),
            NSMakeRange(7, 1),
            NSMakeRange(8, 1),
            NSMakeRange(9, 1),
        ]
        replacements = [
            NSAttributedString.init(string: "Aa"),
            NSAttributedString.init(string: "Bb"),
            NSAttributedString.init(string: "Cc"),
            NSAttributedString.init(string: "Dd"),
            NSAttributedString.init(string: "Ee"),
            NSAttributedString.init(string: "Ff"),
            NSAttributedString.init(string: "Gg"),
            NSAttributedString.init(string: "Hh"),
            NSAttributedString.init(string: "Ii"),
            NSAttributedString.init(string: "Jj"),
        ]
        
        // FIX: can't not pass nil
        //outputString = WCAttributedStringTool.replaceCharactersInRangesWithString(inputString, ranges, replacements, nil)
        //XCTAssertEqual(outputString, NSAttributedString.init(string: "AaBbCcDdEeFfGgHhIiJj"))
        
        outputString = WCAttributedStringTool.replaceCharactersInRangesWithString(inputString, ranges, replacements, &replacementRanges)
        XCTAssertEqual(outputString, NSAttributedString.init(string: "AaBbCcDdEeFfGgHhIiJj"))
        
        // check replacementRanges
        if let replacementRanges = replacementRanges {
            XCTAssertTrue(replacementRanges.count == replacements.count)
            if let outputString = outputString {
                for (index, item) in replacements.enumerated() {
                    let replacementRange: NSRange = replacementRanges[index]
                    let replacementString: NSAttributedString? = WCAttributedStringTool.substringWithString(outputString, replacementRange)
                    XCTAssertEqual(item, replacementString);
                }
            }
        }
        
        // Case 2
        if replacementRanges != nil {
            replacementRanges!.removeAll()
        }
        inputString = NSAttributedString.init(string: "0123456789")
        ranges = [
            NSMakeRange(1, 3),
            NSMakeRange(7, 3),
        ]
        replacements = [
            NSAttributedString.init(string: "A"),
            NSAttributedString.init(string: "B"),
        ]
        
        outputString = WCAttributedStringTool.replaceCharactersInRangesWithString(inputString, ranges, replacements, &replacementRanges)
        XCTAssertEqual(outputString, NSAttributedString.init(string: "0A456B"))
        
        // check replacementRanges
        if let replacementRanges = replacementRanges {
            XCTAssertTrue(replacementRanges.count == replacements.count)
            if let outputString = outputString {
                for (index, item) in replacements.enumerated() {
                    let replacementRange: NSRange = replacementRanges[index]
                    let replacementString: NSAttributedString? = WCAttributedStringTool.substringWithString(outputString, replacementRange)
                    XCTAssertEqual(item, replacementString);
                }
            }
        }
        
        // Case 3
        if replacementRanges != nil {
            replacementRanges!.removeAll()
        }
        inputString = NSAttributedString.init(string: "0123456789")
        ranges = [
            NSMakeRange(1, 3),
            NSMakeRange(7, 2),
        ]
        replacements = [
            NSAttributedString.init(string: "A"),
            NSAttributedString.init(string: "B"),
        ]
        
        outputString = WCAttributedStringTool.replaceCharactersInRangesWithString(inputString, ranges, replacements, &replacementRanges)
        XCTAssertEqual(outputString, NSAttributedString.init(string: "0A456B9"))
        
        // check replacementRanges
        if let replacementRanges = replacementRanges {
            XCTAssertTrue(replacementRanges.count == replacements.count)
            if let outputString = outputString {
                for (index, item) in replacements.enumerated() {
                    let replacementRange: NSRange = replacementRanges[index]
                    let replacementString: NSAttributedString? = WCAttributedStringTool.substringWithString(outputString, replacementRange)
                    XCTAssertEqual(item, replacementString);
                }
            }
        }
        
        // Case 4
        if replacementRanges != nil {
            replacementRanges!.removeAll()
        }
        inputString = NSAttributedString.init(string: "0中文12345678😆9");
        ranges = [
            NSMakeRange(1, 2),
            // Note: 😆'length is 2
            NSMakeRange(11, 2),
        ]
        replacements = [
            NSAttributedString.init(string: "鐘文"),
            NSAttributedString.init(string: "😄"),
        ]
        
        outputString = WCAttributedStringTool.replaceCharactersInRangesWithString(inputString, ranges, replacements, &replacementRanges)
        XCTAssertEqual(outputString, NSAttributedString.init(string: "0鐘文12345678😄9"))
        
        // check replacementRanges
        if let replacementRanges = replacementRanges {
            XCTAssertTrue(replacementRanges.count == replacements.count)
            if let outputString = outputString {
                for (index, item) in replacements.enumerated() {
                    let replacementRange: NSRange = replacementRanges[index]
                    let replacementString: NSAttributedString? = WCAttributedStringTool.substringWithString(outputString, replacementRange)
                    XCTAssertEqual(item, replacementString);
                }
            }
        }
     
        // Case 5
        if replacementRanges != nil {
            replacementRanges!.removeAll()
        }
        inputString = NSAttributedString.init(string: "0123456789")
        ranges = [
            NSMakeRange(9, 1),
            NSMakeRange(8, 1),
            NSMakeRange(7, 1),
            NSMakeRange(6, 1),
            NSMakeRange(5, 1),
            NSMakeRange(4, 1),
            NSMakeRange(3, 1),
            NSMakeRange(2, 1),
            NSMakeRange(1, 1),
            NSMakeRange(0, 1),
        ]
        replacements = [
            NSAttributedString.init(string: "Jj"),
            NSAttributedString.init(string: "Ii"),
            NSAttributedString.init(string: "Hh"),
            NSAttributedString.init(string: "Gg"),
            NSAttributedString.init(string: "Ff"),
            NSAttributedString.init(string: "Ee"),
            NSAttributedString.init(string: "Dd"),
            NSAttributedString.init(string: "Cc"),
            NSAttributedString.init(string: "Bb"),
            NSAttributedString.init(string: "Aa"),
        ]
        
        outputString = WCAttributedStringTool.replaceCharactersInRangesWithString(inputString, ranges, replacements, &replacementRanges)
        XCTAssertEqual(outputString, NSAttributedString.init(string: "AaBbCcDdEeFfGgHhIiJj"))
        
        // check replacementRanges
        if let replacementRanges = replacementRanges {
            XCTAssertTrue(replacementRanges.count == replacements.count)
            if let outputString = outputString {
                for (index, item) in replacements.enumerated() {
                    let replacementRange: NSRange = replacementRanges[index]
                    let replacementString: NSAttributedString? = WCAttributedStringTool.substringWithString(outputString, replacementRange)
                    XCTAssertEqual(item, replacementString);
                }
            }
        }
        
        // Case 6
        if replacementRanges != nil {
            replacementRanges!.removeAll()
        }
        inputString = NSAttributedString.init(string: "0123456789")
        ranges = []
        replacements = []
        
        outputString = WCAttributedStringTool.replaceCharactersInRangesWithString(inputString, ranges, replacements, &replacementRanges)
        XCTAssertEqual(outputString, NSAttributedString.init(string: "0123456789"))
    }
    
}
