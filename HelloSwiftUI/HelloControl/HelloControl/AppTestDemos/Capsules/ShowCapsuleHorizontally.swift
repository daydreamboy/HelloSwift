//
//  ShowCapsuleHorizontally.swift
//  HelloAnimation
//
//  Created by wesley_chen on 2024/1/11.
//

import SwiftUI

struct ShowCapsuleHorizontally: View, DemoPage {
    var body: some View {
        HStack {
            Capsule()
                .fill(.red)
                .frame(height: 100)
                .offset(x: 0, y: 0)
            Capsule()
                .fill(.green)
                .frame(height: 50)
                .offset(x: 0, y: 0)
            // Note: use negative offset y to shift view to top
            Capsule()
                .fill(.yellow)
                .frame(height: 50)
                .offset(x: 0, y: -20)
            Capsule()
                .fill(.blue)
                .frame(height: 50)
                .offset(x: 20, y: 0)
            Capsule()
                .fill(.orange)
                .frame(height: 50)
                .offset(x: 0, y: 0)
        }
        // @see https://codingwithrashid.com/how-to-add-borders-to-hstack-in-ios-swiftui/
        .border(Color.red)
        // Note: width == height will create a circle
        Capsule()
            .fill(.pink)
            .frame(width: 50, height: 50)
            .offset(x: 0, y: 0)
    }
    
    // MARK: DemoPage
    static func createPage(withTitle title: Binding<String>) -> some View {
        ShowCapsuleHorizontally()
    }
}

#Preview {
    ShowCapsuleHorizontally()
}