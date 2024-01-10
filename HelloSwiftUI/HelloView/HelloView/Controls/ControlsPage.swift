//
//  ControlsPage.swift
//  HelloView
//
//  Created by wesley_chen on 2024/1/10.
//

import SwiftUI

struct ControlsPage: View, DemoPage {
    var body: some View {
        EmptyView()
    }
    
    // MARK: DemoPage
    static func createPage(withTitle title: Binding<String>) -> some View {
        ControlsPage()
    }
}

#Preview {
    ControlsPage()
}
