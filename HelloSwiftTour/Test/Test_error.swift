//
//  Test_error.swift
//  Test
//
//  Created by wesley_chen on 2022/3/20.
//

import XCTest

// Note: enum can adpot the Error protocol
enum PrinterError: Error {
    case outOfPaper
    case noToner
    case onFire
}

class Test_error: XCTestCase {
    func send(job: Int, toPrinter printerName: String) throws -> String {
        if printerName == "Never Has Toner" {
            throw PrinterError.noToner
        }
        return "Job sent"
    }
    
    func test_errro_handling_with_do_catch() throws {
        do {
            let printerResponse = try send(job: 1040, toPrinter: "Bi Sheng")
            print(printerResponse)
        } catch {
            print(error)
        }
        // Prints "Job sent"
    }
    
    func test_errro_handling_with_multiple_catch() throws {
        do {
            let printerResponse = try send(job: 1440, toPrinter: "Gutenberg")
            print(printerResponse)
        } catch PrinterError.onFire {
            print("I'll just put this over here, with the rest of the fire.")
        } catch let printerError as PrinterError {
            print("Printer error: \(printerError).")
        } catch {
            print(error)
        }
        // Prints "Job sent"
        
        do {
            let printerResponse = try send(job: 1440, toPrinter: "Never Has Toner")
            print(printerResponse)
        } catch PrinterError.onFire {
            print("I'll just put this over here, with the rest of the fire.")
        } catch let printerError as PrinterError {
            print("Printer error: \(printerError).")
        } catch {
            print(error)
        }
        // Prints "Printer error: noToner."
    }
    
    func test_errro_handling_use_try() throws {
        let printerSuccess = try? send(job: 1884, toPrinter: "Mergenthaler")
        let printerFailure = try? send(job: 1885, toPrinter: "Never Has Toner")
        
        print(printerSuccess as Any)
        print(printerFailure as Any)
    }
}
