//
//  Test.swift
//  Test
//
//  Created by wesley_chen on 2022/3/20.
//

import XCTest

extension Array where Element:Equatable {
    func uniqued() -> [Element] {
        var result = [Element]()

        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }

        return result
    }
}

class SomeClass: NSObject {
    public var restrictedSteamWords: [String]? {
        // @see https://stackoverflow.com/a/24334029
        didSet {
            if restrictedSteamWords != nil {
                restrictedSteamWords = restrictedSteamWords!.uniqued()
            }
        }
    }
}

private class Test: XCTestCase {
    func testExample() throws {
        let o = SomeClass()
        o.restrictedSteamWords = nil
        print(o.restrictedSteamWords as Any)
        
        o.restrictedSteamWords = [ "a", "b", "a" ]
        print(o.restrictedSteamWords as Any)
    }
    
    func test_date() throws {
        let formatter = DateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
        formatter.dateFormat = "YYYY-MM-dd HH:mm:ss.SSS"
        var date = formatter.date(from: "2022-06-27 09:10:53.426")
        print(date)
    }
}
