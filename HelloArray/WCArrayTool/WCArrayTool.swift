//
//  WCArrayTool.swift
//  HelloArray
//
//  Created by wesley_chen on 2022/7/2.
//

import UIKit

// @see https://stackoverflow.com/a/35014912
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

class WCArrayTool: NSObject {

}
