//
//  Test_keyword_any.swift
//  Test
//
//  Created by wesley_chen on 2023/11/14.
//

import XCTest

protocol Vehicle {
    func travel(to destination: String)
}

struct Car: Vehicle {
    func travel(to destination: String) {
        print("I'm driving to \(destination)")
    }
}

func travel2(to destinations: [String], using vehicle: Vehicle) {
    for destination in destinations {
        vehicle.travel(to: destination)
    }
}

func travel3(to destinations: [String], using vehicle: any Vehicle) {
    for destination in destinations {
        vehicle.travel(to: destination)
    }
}

protocol P {}
protocol Q {}
struct S: P, Q {}

final class Test_keyword_any: XCTestCase {
    func test_any_used_only_for_protocol() throws {
        let _: P = S() // 'P' in this context is an existential type
        let _: any P = S() // 'any P' is an explicit existential type

        let _: P & Q = S() // 'P & Q' in this context is an existential type
        let _: any P & Q = S() // 'any P & Q' is an explicit existential typeU
    }
    
    func test_any_not_for_concret_type() throws {
        /*
        let s: any S = S() // error: 'any' has no effect on concrete type 'S'

        func generic<T>(t: T) {
          let x: any T = t // error: 'any' has no effect on type parameter 'T'
        }

        let f: any ((Int) -> Void) = generic // error: 'any' has no effect on concrete type
         */
    }
    
    func test_temp() throws {
        let vehicle = Car()
        vehicle.travel(to: "London")

        let vehicle2: Vehicle = Car()
        vehicle2.travel(to: "Glasgow")
        
        let vehicle3: any Vehicle = Car()
        vehicle3.travel(to: "Glasgow")

        travel3(to: ["London", "Amarillo"], using: vehicle3)
    }
}
