//
//  UseSceneView.swift
//  AppTestTemplate
//
//  Created by wesley_chen on 2024/1/7.
//

import SwiftUI
import SceneKit

struct UseSceneView: View, DemoPage {
    @Binding var title: String
    
    let scene = GameScene()

    var body: some View {
        VStack {
            SceneView(scene: scene, pointOfView: scene.cameraNode, options: .allowsCameraControl)
                .ignoresSafeArea()
            Text("Hello, 3D world!")
                .font(.largeTitle)
                .fontWeight(.bold)
        }
    }
    
    // MARK: DemoPage
    static func createPage(withTitle title: Binding<String>) -> some View {
        UseSceneView.init(title: title)
    }
}

// Xcode15+
#if swift(>=5.9)
#Preview {
    UseSceneView(title: .constant("This is a demo"))
}
#else
struct DemoPage1_Previews: PreviewProvider {
    static var previews: some View {
        UseSceneView(title: .constant("This is a demo"))
    }
}
#endif
