//
//  WCDumpTool.swift
//  HelloSwiftTour
//
//  Created by wesley_chen on 2023/11/7.
//

import Foundation

/// Dump Any type object
///
/// - Parameter object: the `Any` type
///
func dump_object(_ object: Any) {
    switch object {
    case let anyObject as AnyObject:
        print("(\(type(of: object))) \(Unmanaged.passUnretained(anyObject).toOpaque()) = `\(anyObject)`")
    default:
        print("(\(type(of: object))) Unknown = `\(object)`")
    }
}
