//
//  UseNavigationSplitView.swift
//  HelloNavigation
//
//  Created by wesley_chen on 2023/11/26.
//

import SwiftUI

struct UseNavigationSplitView: View, DemoPage {
    var body: some View {
        NavigationSplitView {
            List(landmarks) { landmark in
                NavigationLink {
                    ListRowDetailView(landmark: landmark)
                } label: {
                    ListRowView(landmark: landmark)
                }
            }
            .navigationTitle("Landmarks")
        } detail: {
            Text("Select a Landmark")
        }
    }
    
    // MARK: DemoPage
    static func createPage(withTitle title: Binding<String>) -> some View {
        UseNavigationSplitView().navigationBarTitleDisplayMode(.inline)
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        UseNavigationSplitView()
    }
}
