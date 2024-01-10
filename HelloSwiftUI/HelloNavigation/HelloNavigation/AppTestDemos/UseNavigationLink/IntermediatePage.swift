//
//  IntermediatePage.swift
//  HelloNavigation
//
//  Created by wesley_chen on 2024/1/10.
//

import SwiftUI

struct IntermediatePage: View, DemoPage {
    var body: some View {
        List {
            NavigationLink("Go to leaf page", destination: LeafPage())
        }
        .navigationTitle("Intermediate Page")
    }
    
    // MARK: DemoPage
    static func createPage(withTitle title: Binding<String>) -> some View {
        IntermediatePage()
    }
}

struct IntermediatePage_Previews: PreviewProvider {
    static var previews: some View {
        IntermediatePage()
    }
}
