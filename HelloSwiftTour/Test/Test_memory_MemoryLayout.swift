//
//  Test_memory_MemoryLayout.swift
//  Test
//
//  Created by wesley_chen on 2023/12/6.
//

import XCTest

final class Test_memory_MemoryLayout: XCTestCase {
    struct Point {
        let x: Double
        let y: Double
        let isFilled: Bool
    }
    
    func test_use_MemoryLayout() throws {
        XCTAssertTrue(MemoryLayout<Point>.size == 17)
        XCTAssertTrue(MemoryLayout<Point>.stride == 24)
        XCTAssertTrue(MemoryLayout<Point>.alignment == 8)
        
        // Step1: allocate typed memory
        let count = 4
        let pointPointer = UnsafeMutableRawPointer.allocate(
                byteCount: count * MemoryLayout<Point>.stride,
                alignment: MemoryLayout<Point>.alignment)
        //print(address: pointPointer, as: Array<Any>.self)
        
        // Step2: write
        let points = pointPointer.assumingMemoryBound(to: Point.self)
        for i in 0..<count {
            points[i] = Point(x: Double(i), y: Double(i) * 2, isFilled: true)
        }
        
        // Step3: read
        let points2 = pointPointer.assumingMemoryBound(to: Point.self)
        for i in 0..<count {
            let point = points2[i]
            Swift.print(point)
        }
        
        // Step4: index
        let point3 = points[3]
        Swift.print(point3)
        
        pointPointer.deallocate()
    }
    
    func print<T>(address p: UnsafeMutableRawPointer, as type: T.Type) {
        let value = p.load(as: type)
        Swift.print(value)
    }
}
