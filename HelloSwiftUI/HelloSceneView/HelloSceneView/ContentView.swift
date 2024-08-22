//
//  ContentView.swift
//  AppTestTemplate
//
//  Created by wesley_chen on 2023/11/25.
//

import SwiftUI

struct ContentView: View {
    let pageItems1: [(title: String, pageType: any DemoPage.Type)] = [
        (title: "Demo1", pageType: UseSceneView.self),
        (title: "Demo2", pageType: DemoPage2.self),
        (title: "Demo3", pageType: DemoPage3.self),
    ]
    
    let pageItems2: [(title: String, pageType: any DemoPage.Type)] = [
        (title: "Demo1", pageType: UseSceneView.self),
        (title: "Demo2", pageType: DemoPage2.self),
        (title: "Demo3", pageType: DemoPage3.self),
    ]
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    // Note: use ForEach to traverse pageItems
                    ForEach(pageItems1, id: \.title) { item in
                        NavigationLink(item.title, destination: AnyView(item.pageType.createPage(withTitle: .constant(item.title))).navigationBarTitle(item.title).navigationBarTitleDisplayMode(.inline))
                    }
                } header: {
                    Text("pageItems1")
                }
                
                Section {
                    // Note: use ForEach to traverse pageItems
                    ForEach(pageItems2, id: \.title) { item in
                        NavigationLink(item.title, destination: AnyView(item.pageType.createPage(withTitle: .constant(item.title))).navigationBarTitle(item.title).navigationBarTitleDisplayMode(.inline))
                    }
                } header: {
                    Text("pageItems2")
                }
            }
            .navigationTitle("Demos")

            Text("Select a demo") // A placeholder to show before selection.
        }
    }
}

// Xcode15+
#if swift(>=5.9)
#Preview {
    ContentView()
}
#else
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
