//
//  Test_enum.swift
//  Test
//
//  Created by wesley_chen on 2022/3/20.
//

import XCTest

enum Rank: Int {
    case ace = 1
    case two, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king

    func simpleDescription() -> String {
        switch self {
        case .ace:
            return "ace"
        case .jack:
            return "jack"
        case .queen:
            return "queen"
        case .king:
            return "king"
        default:
            return String(self.rawValue)
        }
    }
}

enum ServerResponse {
    case result(String, String)
    case failure(String)
}

private class Test_enum: XCTestCase {
    func test_enum() throws {
        let ace = Rank.ace
        print(ace)
        
        let aceRawValue = ace.rawValue
        print(aceRawValue)
    }
    
    func test_enum_with_associated_value() throws {
        let success = ServerResponse.result("6:00 am", "8:09 pm")
        let failure = ServerResponse.failure("Out of cheese.")

        switch success {
        case let .result(sunrise, sunset):
            print("Sunrise is at \(sunrise) and sunset is at \(sunset).")
        case let .failure(message):
            print("Failure...  \(message)")
        }
    }
}
