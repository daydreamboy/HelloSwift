//
//  ContentView.swift
//  AppTestTemplate
//
//  Created by wesley_chen on 2023/11/25.
//

import SwiftUI

struct ContentView: View {
    let pageItems: [(title: String, pageType: any DemoPage.Type)] = [
        (title: "Use ForEach", pageType: UseForEach.self),
        (title: "Use Group", pageType: UseGroup.self),
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
