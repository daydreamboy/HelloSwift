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

class Test: XCTestCase {
    func testExample() throws {
        let o = SomeClass()
        o.restrictedSteamWords = nil
        print(o.restrictedSteamWords as Any)
        
        o.restrictedSteamWords = [ "a", "b", "a" ]
        print(o.restrictedSteamWords as Any)
    }
}
