//
//  ControlsPage.swift
//  HelloView
//
//  Created by wesley_chen on 2024/1/10.
//

import SwiftUI

struct ControlsPage: View, DemoPage {
    let capsuleItems: [(title: String, pageType: any DemoPage.Type)] = [
        (title: "show Capsule vertically", pageType: ShowCapsuleVertically.self),
        (title: "show Capsule horizontally", pageType: ShowCapsuleHorizontally.self),
        (title: "show Capsule aligned", pageType: ShowCapsuleAligned.self),
    ]
    
    var body: some View {
        List {
            // @see https://www.hackingwithswift.com/quick-start/swiftui/how-to-add-sections-to-a-list
            Section(header: Text("Capsules")) {
                // Note: use ForEach to traverse pageItems
                ForEach(capsuleItems, id: \.title) { item in
                    NavigationLink(item.title, destination: AnyView(item.pageType.createPage(withTitle: .constant(item.title))).navigationBarTitle(item.title).navigationBarTitleDisplayMode(.inline))
                }
            }
            .headerProminence(.increased)
            
            
        }
    }
    
    // MARK: DemoPage
    static func createPage(withTitle title: Binding<String>) -> some View {
        ControlsPage()
    }
}

#Preview {
    ControlsPage()
}
