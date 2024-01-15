//
//  ContentView.swift
//  AppTestTemplate
//
//  Created by wesley_chen on 2023/11/25.
//

import SwiftUI

struct ContentView: View {
    let pageItems: [(title: String, pageType: any DemoPage.Type)] = [
        (title: "Show multiple Capsules vertically", pageType: ShowCapsuleVertically.self),
        (title: "Show multiple Capsules horizontally", pageType: ShowCapsuleHorizontally.self),
        (title: "Show GraphCapsule", pageType: ShowGraphCapsule.self),
        (title: "Show HikeGraph", pageType: ShowHikeGraph.self),
        (title: "Demo3", pageType: DemoPage3.self),
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
