//
//  ShowCapsuleVertically.swift
//  HelloAnimation
//
//  Created by wesley_chen on 2024/1/11.
//

import SwiftUI

struct ShowCapsuleVertically: View, DemoPage {
    var body: some View {
        VStack {
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
        }
        .border(Color.red)
    }
    
    // MARK: DemoPage
    static func createPage(withTitle title: Binding<String>) -> some View {
        ShowCapsuleVertically()
    }
}

#Preview {
    ShowCapsuleVertically()
}
