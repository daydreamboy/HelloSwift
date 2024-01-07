//
//  ContentView.swift
//  HelloDrawing
//
//  Created by wesley_chen on 2024/1/7.
//

import SwiftUI

struct ContentView: View {
    let pageItems: [(title: String, pageType: any DemoPage.Type)] = [
        (title: "Show badge", pageType: ShowBadge.self),
        (title: "Show badge symbol", pageType: ShowBadgeSymbol.self),
        (title: "Show badge background", pageType: ShowBadgeBackground.self),
        (title: "Show rotated badge symbol", pageType: ShowRotatedBadgeSymbol.self),
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

// Note: Xcode15 provide Swift 5.9+
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
