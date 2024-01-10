//
//  LayoutsPage.swift
//  HelloView
//
//  Created by wesley_chen on 2024/1/10.
//

import SwiftUI

struct LayoutsPage: View, DemoPage {
    var body: some View {
        List {
            NavigationLink("Use Group", destination: UseGroup())
            NavigationLink("Use .offset", destination: UseOffset())
        }
    }
    
    // MARK: DemoPage
    static func createPage(withTitle title: Binding<String>) -> some View {
        LayoutsPage()
    }
}

#Preview {
    LayoutsPage()
}
