//
//  Test_class.swift
//  Test
//
//  Created by wesley_chen on 2022/3/20.
//

import XCTest

class NamedShape {
    var numberOfSides: Int = 0
    var name: String

    init(name: String) {
        self.name = name
    }

    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}

class Square: NamedShape {
    var sideLength: Double

    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 4
    }

    func area() -> Double {
        return sideLength * sideLength
    }

    override func simpleDescription() -> String {
        return "A square with sides of length \(sideLength)."
    }
}

class Test_class: XCTestCase {
    func test_create_an_instance() throws {
        let object = NamedShape(name: "Square")
        print(object)
        
        // Error: no constructor function without parameter
        /*
        let object2 = NamedShape()
        print(object2)
         */
    }
    
    func test_create_an_instance_of_subclass() throws {
        let test = Square(sideLength: 5.2, name: "my test square")
        _ = test.area()
        _ = test.simpleDescription()
    }
    
    func test_an_optional_instance() throws {
        let optionalSquare: Square? = Square(sideLength: 2.5, name: "optional square")
        let sideLength = optionalSquare?.sideLength
        print(sideLength as Any)
    }
}
