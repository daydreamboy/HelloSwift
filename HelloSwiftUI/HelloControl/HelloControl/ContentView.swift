//
//  ContentView.swift
//  AppTestTemplate
//
//  Created by wesley_chen on 2023/11/25.
//

import SwiftUI

struct ContentView: View {
    let capsuleItems: [(title: String, pageType: any DemoPage.Type)] = [
        (title: "show Capsule vertically", pageType: ShowCapsuleVertically.self),
        (title: "show Capsule horizontally", pageType: ShowCapsuleHorizontally.self),
        (title: "show Capsule aligned", pageType: ShowCapsuleAligned.self),
    ]
    
    let toggleItems: [(title: String, pageType: any DemoPage.Type)] = [
        (title: "Toggle Initialization", pageType: ToggleInitialization.self),
        (title: "Toggle Style", pageType: ToggleStyle.self),
    ]
    
    let pickerItems: [(title: String, pageType: any DemoPage.Type)] = [
        (title: "Use Picker", pageType: UsePicker.self),
    ]
    
    let propertyItems: [(title: String, pageType: any DemoPage.Type)] = [
        (title: ".offset", pageType: UseOffset.self),
    ]
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    // Note: use ForEach to traverse pageItems
                    ForEach(capsuleItems, id: \.title) { item in
                        NavigationLink(item.title, destination: AnyView(item.pageType.createPage(withTitle: .constant(item.title))).navigationBarTitle(item.title).navigationBarTitleDisplayMode(.inline))
                    }
                } header: {
                    Text("Capsule")
                }
                
                Section {
                    ForEach(toggleItems, id: \.title) { item in
                        NavigationLink(item.title, destination: AnyView(item.pageType.createPage(withTitle: .constant(item.title))).navigationBarTitle(item.title).navigationBarTitleDisplayMode(.inline))
                    }
                } header: {
                    Text("Toggle")
                }
                
                Section {
                    ForEach(pickerItems, id: \.title) { item in
                        NavigationLink(item.title, destination: AnyView(item.pageType.createPage(withTitle: .constant(item.title))).navigationBarTitle(item.title).navigationBarTitleDisplayMode(.inline))
                    }
                } header: {
                    Text("Picker")
                }
                
                Section {
                    ForEach(propertyItems, id: \.title) { item in
                        NavigationLink(item.title, destination: AnyView(item.pageType.createPage(withTitle: .constant(item.title))).navigationBarTitle(item.title).navigationBarTitleDisplayMode(.inline))
                    }
                } header: {
                    Text("Properties")
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
