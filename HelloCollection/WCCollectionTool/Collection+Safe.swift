//
//  Collection+Safe.swift
//  HelloCollection
//
//  Created by wesley_chen on 2023/6/11.
//

import Foundation

// @see https://stackoverflow.com/questions/37222811/how-do-i-catch-index-out-of-range-in-swift
extension Collection where Indices.Iterator.Element == Index {
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

