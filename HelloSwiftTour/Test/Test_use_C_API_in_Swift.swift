//
//  Test_use_C_API_in_Swift.swift
//  Test
//
//  Created by wesley_chen on 2024/8/14.
//

import XCTest

final class Test_use_C_API_in_Swift: XCTestCase {
    func test_use_struct_Color() throws {
        let c1 = Color.init()
        let c2 = Color.init(r: 1, g: 1, b: 1)
        
        print(c1.r)
        print(c2.r, c2.g, c2.b)
    }
    
    func test_use_union_SchroedingersCat() throws {
        var mittens = SchroedingersCat(isAlive: false)

        print(mittens.isAlive, mittens.isDead) // Prints "false false"
        XCTAssertFalse(mittens.isAlive)
        XCTAssertFalse(mittens.isDead)

        mittens.isAlive = true
        print(mittens.isDead) // Prints "true"
        XCTAssertTrue(mittens.isAlive)
    }
    
    func test_use_nested_struct_SmallCake() throws {
        var simpleCake = SmallCake()
        simpleCake.size.layers = 5
        print(simpleCake.toppings.icing) // Prints "false"
        XCTAssertFalse(simpleCake.toppings.icing)
        
        let cake = SmallCake(
            size: U1(layers: 2),
            toppings: .init(icing: true, sprinkles: false)
        )
        
        print("The cake has \(cake.size.layers) layers.") // Prints "The cake has 2 layers."
        print("Does it have sprinkles?", cake.toppings.sprinkles ? "Yes." : "No.") // Prints "Does it have sprinkles? No."
    }
    
    func test_use_unnamed_struct_Cake() throws {
        var simpleCake = Cake()
        simpleCake.layers = 5
        print(simpleCake.toppings.icing) // Prints "false"
        XCTAssertFalse(simpleCake.toppings.icing)
        
        let cake = Cake(
            .init(layers: 2),
            toppings: .init(icing: true, sprinkles: false)
        )
        
        print("The cake has \(cake.layers) layers.") // Prints "The cake has 2 layers."
        print("Does it have sprinkles?", cake.toppings.sprinkles ? "Yes." : "No.") // Prints "Does it have sprinkles? No."
    }
    
    func test_use_macro() throws {
        print(FADE_ANIMATION_DURATION)
        print(VERSION_STRING)
        print(MAX_RESOLUTION)
        
//        print(HALF_RESOLUTION)
//        print(IS_HIGH_RES)
//        
//        let _ = FADE_ANIMATION_DURATION
//        let _ = HALF_RESOLUTION
    }
    
    func test_use_function() throws {
        // Case1
        let r1 = product(3, 4);
        XCTAssertEqual(r1, 12)
        
        // Case2
        let a: Int32 = 5
        let b: Int32 = 2
        var r2: Int32 = 0
        let r3 = quotient(a, b, &r2)
        print("\(a) / \(b) = \(r3)")
        print("\(a) % \(b) = \(r2)")
        
        // Case 3
        let ptr: UnsafeMutablePointer<Int32>? = nil
        let _ = quotient(a, b, ptr)
        // Note: ptr?.pointee return a generic type Pointee which now is Int32
        let reminder: Int32? = ptr?.pointee
        if let value = reminder {
            print("Pointer value is: \(value)")
        } else {
            print("Pointer is nil")
        }
        
        // Case4
        let p1 = createPoint2D(3, 3)
        let p2 = createPoint2D(4, 4)
        let d = distance(p1, p2)
        print("d = \(d)")
    }
    
    func test_use_variadic_function_vasprintf() throws {
        print(wrappper_for_vasprintf(format: "√2 ≅ %g", arguments: sqrt(2.0))!) // Prints "√2 ≅ 1.41421"
    }
    
    func wrappper_for_vasprintf(format: String, arguments: CVarArg...) -> String? {
        // withVaList is Swift helper function to get va_list
        return withVaList(arguments) { va_list in
            var buffer: UnsafeMutablePointer<Int8>? = nil
            return format.withCString { cString in
                // Note: vasprintf is a C function using va_list type
                guard vasprintf(&buffer, cString, va_list) != 0 else {
                    return nil
                }

                return String(validatingUTF8: buffer!)
            }
        }
    }
    
    func test_use_variadic_func_with_vaList_1() throws {
        // Error: 'variadic_func1' is unavailable: Variadic function is unavailable
        //variadic_func1
        
        // Case 1
        let count: Int32 = 3
        let values: [Int32] = [1, 2, 3]
        let result1: Int32 = withVaList(values) { vaListPointer in
            return variadic_func_with_vaList(count, vaListPointer)
        }
        XCTAssert(result1 == 6)
        
        // Case 2
        let result2: Int32 = wrappper1_for_variadic_func_with_vaList(count: 3, arguments: 1, 2, 3)
        XCTAssert(result2 == 6)
        
        // Case 3
        let result3: Int32 = wrappper2_for_variadic_func_with_vaList(3, 4, 5, 6)
        XCTAssert(result3 == 15)
    }
    
    func wrappper1_for_variadic_func_with_vaList(count: Int32, arguments: CVarArg...) -> Int32 {
        return variadic_func_with_vaList(count, getVaList(arguments))
    }
    
    func wrappper2_for_variadic_func_with_vaList(_ count: Int32, _ arguments: CVarArg...) -> Int32 {
        return withVaList(arguments) { va_list in
            return variadic_func_with_vaList(count, va_list)
        }
    }
}
