//
//  UseScaleEffect.swift
//  AppTestTemplate
//
//  Created by wesley_chen on 2024/1/7.
//

import SwiftUI

struct UseScaleEffect: View, DemoPage {
    @Binding var title: String
    @State private var scale = 1.0

    var body: some View {
        VStack {
            Image(systemName: "envelope.badge.fill")
                .resizable()
                .frame(width: 100, height: 100, alignment: .center)
                .foregroundColor(Color.red)
                .scaleEffect(scale, anchor: .leading)
                .border(Color.gray)
                .animation(.easeIn, value: scale)
            Image(systemName: "envelope.badge.fill")
                .resizable()
                .frame(width: 100 * scale, height: 100 * scale, alignment: .center)
                .foregroundColor(Color.red)
                .border(Color.gray)
                .animation(.easeIn, value: scale)
            HStack {
                Button("+") { scale += 0.5 }
                Button("-") { scale -= 0.5 }
            }
        }
    }
    
    // MARK: DemoPage
    static func createPage(withTitle title: Binding<String>) -> some View {
        UseScaleEffect.init(title: title)
    }
}

struct UseScaleEffect_Previews: PreviewProvider {
    static var previews: some View {
        UseScaleEffect(title: .constant("This is a demo"))
    }
}
