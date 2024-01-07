//
//  DemoPage1.swift
//  AppTestTemplate
//
//  Created by wesley_chen on 2024/1/7.
//

import SwiftUI

struct DemoPage1: View, DemoPage {
    @Binding var title: String

    var body: some View {
        Text("This is demo1").navigationBarTitle(title).navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: DemoPage
    static func createPage(withTitle title: Binding<String>) -> some View {
        DemoPage1.init(title: title)
    }
}

struct DemoPage1_Previews: PreviewProvider {
    static var previews: some View {
        DemoPage1(title: .constant("This is a demo"))
    }
}
