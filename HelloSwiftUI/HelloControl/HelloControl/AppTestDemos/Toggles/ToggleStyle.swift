//
//  ToggleStyle.swift
//  AppTestTemplate
//
//  Created by wesley_chen on 2024/1/7.
//

import SwiftUI

struct ToggleStyle: View, DemoPage {
    @Binding var title: String
    @State private var vibrateOnRing = false
    @State private var vibrateOnSilent = false

    var body: some View {
        VStack {
            Toggle(isOn: $vibrateOnRing) {
                Text("Vibrate on Ring")
            }
            
            if #available(iOS 15.0, *) {
                Toggle(isOn: $vibrateOnRing) {
                    Text("Vibrate on Ring")
                }
                .toggleStyle(.button)
            }
            
            Toggle(isOn: $vibrateOnRing) {
                Text("Vibrate on Ring")
            }
            .toggleStyle(.automatic)
            
            Toggle(
                "Vibrate on Ring",
                systemImage: "dot.radiowaves.left.and.right",
                isOn: $vibrateOnRing
            )
            
            if #available(iOS 15.0, *) {
                Toggle(
                    "Vibrate on Ring",
                    systemImage: "dot.radiowaves.left.and.right",
                    isOn: $vibrateOnRing
                )
                .toggleStyle(.button)
            }
            
            Toggle("", isOn: $vibrateOnRing)
        }
    }
    
    // MARK: DemoPage
    static func createPage(withTitle title: Binding<String>) -> some View {
        ToggleStyle.init(title: title)
    }
}

struct DemoPage2_Previews: PreviewProvider {
    static var previews: some View {
        ToggleStyle(title: .constant("This is a demo"))
    }
}
