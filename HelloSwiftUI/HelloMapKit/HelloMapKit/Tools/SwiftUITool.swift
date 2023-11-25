//
//  BoolTool.swift
//  HelloMapKit
//
//  Created by wesley_chen on 2023/11/25.
//

import Foundation
import SwiftUI

extension Bool {
    static var iOS15OrLater: Bool {
        guard #available(iOS 15, *) else {
            // It's iOS 14 or before
            return false
        }
        // It's iOS 15 or later
        return true
    }
}

// TODO: test
// @see https://www.avanderlee.com/swiftui/conditional-view-modifier/
extension View {
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
