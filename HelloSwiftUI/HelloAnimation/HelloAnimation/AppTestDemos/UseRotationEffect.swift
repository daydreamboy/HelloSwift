//
//  UseRotationEffect.swift
//  AppTestTemplate
//
//  Created by wesley_chen on 2024/1/7.
//

import SwiftUI

struct UseRotationEffect: View, DemoPage {
    @Binding var title: String
    @State private var rotationAngle: Double = 0
    @State private var rotateTo360Degree = false

    var body: some View {
        VStack {
            Button("Rotate") {
                rotationAngle += 20
            }
            
            Text("Rotation by passing an angle in degrees")
                .rotationEffect(.degrees(rotationAngle))
                .border(Color.gray)
                .animation(.easeInOut, value: rotationAngle)
            
            if #available(iOS 15.0, *) {
                Toggle(rotateTo360Degree ? "Rotate to 0º" : "Rotate to 360º", isOn: $rotateTo360Degree)
                    .toggleStyle(.button)
            }
            Text("Rotation by passing an angle in degrees")
                .rotationEffect(.degrees(rotateTo360Degree ? 360 : 0))
                .border(Color.gray)
                .animation(.easeInOut, value: rotateTo360Degree)
        }
    }
    
    // MARK: DemoPage
    static func createPage(withTitle title: Binding<String>) -> some View {
        UseRotationEffect.init(title: title)
    }
}

struct UseRotationEffect_Previews: PreviewProvider {
    static var previews: some View {
        UseRotationEffect(title: .constant("This is a demo"))
    }
}
