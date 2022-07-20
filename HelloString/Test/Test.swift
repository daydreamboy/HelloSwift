//
//  Test.swift
//  Test
//
//  Created by wesley_chen on 2022/5/26.
//

import XCTest

class Test: XCTestCase {
    func test_URLEscapedString() throws {
        XCTAssertEqual(WCStringTool.URLEscapedString(":"), "%3A")
        XCTAssertEqual(WCStringTool.URLEscapedString("/"), "%2F")
        XCTAssertEqual(WCStringTool.URLEscapedString("?"), "%3F")
        XCTAssertEqual(WCStringTool.URLEscapedString("&"), "%26")
        XCTAssertEqual(WCStringTool.URLEscapedString("="), "%3D")
        XCTAssertEqual(WCStringTool.URLEscapedString(";"), "%3B")
        XCTAssertEqual(WCStringTool.URLEscapedString("+"), "%2B")
        XCTAssertEqual(WCStringTool.URLEscapedString("!"), "%21")
        XCTAssertEqual(WCStringTool.URLEscapedString("@"), "%40")
        XCTAssertEqual(WCStringTool.URLEscapedString("#"), "%23")
        XCTAssertEqual(WCStringTool.URLEscapedString("$"), "%24")
        XCTAssertEqual(WCStringTool.URLEscapedString("("), "%28")
        XCTAssertEqual(WCStringTool.URLEscapedString(")"), "%29")
        XCTAssertEqual(WCStringTool.URLEscapedString("'"), "%27")
        XCTAssertEqual(WCStringTool.URLEscapedString(","), "%2C")
        XCTAssertEqual(WCStringTool.URLEscapedString("*"), "%2A")
        XCTAssertEqual(WCStringTool.URLEscapedString("["), "%5B")
        XCTAssertEqual(WCStringTool.URLEscapedString("]"), "%5D")
        XCTAssertEqual(WCStringTool.URLEscapedString("{"), "%7B")
        XCTAssertEqual(WCStringTool.URLEscapedString("}"), "%7D")
    }
    
    func test_matchedStringWithString() throws {
        var string: String
        var output: String?
        
        // Case 1
        string = "2022-06-27 09:18:54.657 [0x28298f900] 11288: [DG] DGATLog [vcDisAppear]  DGConversationListViewController"
        output = WCStringTool.matchedStringWithString(string: string, pattern: "\\[vcDisAppear\\]")?.first
        XCTAssertEqual(output, "[vcDisAppear]")
        print(output as Any)
        
        // Case 2
        string = "2022-06-27 09:18:54.657 [0x28298f900] 11288: [DG] DGATLog [vcDisAppear]  DGConversationListViewController"
        output = WCStringTool.matchedStringWithString(string: string, pattern: "\\[vcDisAppear\\]  ([a-zA-Z]+)")?.first
        XCTAssertEqual(output, "DGConversationListViewController")
        print(output as Any)
    }
}
