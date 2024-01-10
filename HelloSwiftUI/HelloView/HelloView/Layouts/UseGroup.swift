//
//  UseGroup.swift
//  HelloView
//
//  Created by wesley_chen on 2024/1/10.
//

import SwiftUI

struct UseGroup: View, DemoPage {
    var body: some View {
        Group {
            Text("SwiftUI")
            Text("Combine")
            Text("Swift System")
        }
        .font(.headline)
    }
    
    // MARK: DemoPage
    static func createPage(withTitle title: Binding<String>) -> some View {
        UseGroup()
    }
}

struct UseGroup_Previews: PreviewProvider {
    static var previews: some View {
        UseGroup()
    }
}
