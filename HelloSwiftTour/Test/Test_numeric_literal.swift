//
//  Test_numeric_literal.swift
//  Test
//
//  Created by wesley_chen on 2022/3/26.
//

import XCTest

class Test_numeric_literal: XCTestCase {

    func test_numeric_literal_with_padding_zeros() throws {
        let paddedDouble1 = 000123.456
        let paddedDouble2 = 123.456000
        let paddedInteger = 007
        
        print(paddedDouble1)
        print(paddedDouble2)
        print(paddedInteger)
    }
    
    func test_numeric_literal_with_underscore() throws {
        let oneMillion1 = 1_000_000
        let oneMillion2 = 100_00_00
        let justOverOneMillion = 1_000_000.000_000_1
        let paddedInteger = 0_0_7
        
        print(oneMillion1)
        print(oneMillion2)
        print(justOverOneMillion)
        print(paddedInteger)
    }
}
