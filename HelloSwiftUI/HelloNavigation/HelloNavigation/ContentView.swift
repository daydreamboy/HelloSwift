//
//  ContentView.swift
//  HelloNavigation
//
//  Created by wesley_chen on 2023/11/25.
//

import SwiftUI

struct ContentView: View {
    let pageItems: [(title: String, pageType: any DemoPage.Type)] = [
        (title: "Use NavigationSplitView", pageType: UseNavigationSplitView.self),
        (title: "Use NavigationLink", pageType: IntermediatePage.self),
    ]
    
    var body: some View {
        NavigationView {
            List {
                // Note: use ForEach to traverse pageItems
                ForEach(pageItems, id: \.title) { item in
                    NavigationLink(item.title, destination: AnyView(item.pageType.createPage(withTitle: .constant(item.title))).navigationBarTitle(item.title).navigationBarTitleDisplayMode(.inline))
                }
            }
            .navigationTitle("Demos")

            Text("Select a demo") // A placeholder to show before selection.
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
