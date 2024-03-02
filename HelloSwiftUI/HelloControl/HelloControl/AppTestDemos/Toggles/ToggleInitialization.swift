//
//  ToggleInitialization.swift
//  AppTestTemplate
//
//  Created by wesley_chen on 2024/1/7.
//

import SwiftUI

struct ToggleInitialization: View, DemoPage {
    @Binding var title: String
    @State private var vibrateOnRing = false
    @State private var vibrateOnSilent = false

    var body: some View {
        VStack {
            Toggle(isOn: $vibrateOnRing) {
                Text("Vibrate on Ring")
            }
            
            Toggle(
                "Vibrate on Ring",
                systemImage: "dot.radiowaves.left.and.right",
                isOn: $vibrateOnRing
            )
            
            Toggle("Vibrate on Ring", isOn: $vibrateOnRing)
            
            VStack {
                Toggle("Vibrate on Ring", isOn: $vibrateOnRing)
                Toggle("Vibrate on Silent", isOn: $vibrateOnSilent)
            }
            .toggleStyle(.switch)
        }
    }
    
    // MARK: DemoPage
    static func createPage(withTitle title: Binding<String>) -> some View {
        ToggleInitialization.init(title: title)
    }
}

struct DemoPage1_Previews: PreviewProvider {
    static var previews: some View {
        ToggleInitialization(title: .constant("This is a demo"))
    }
}
