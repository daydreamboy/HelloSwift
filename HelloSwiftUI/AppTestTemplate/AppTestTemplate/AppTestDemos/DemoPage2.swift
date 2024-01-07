//
//  DemoPage2.swift
//  AppTestTemplate
//
//  Created by wesley_chen on 2024/1/7.
//

import SwiftUI

struct DemoPage2: View, DemoPage {
    @Binding var title: String

    var body: some View {
        Text("This is demo2").navigationBarTitle(title).navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: DemoPage
    static func createPage(withTitle title: Binding<String>) -> some View {
        DemoPage2.init(title: title)
    }
}

struct DemoPage2_Previews: PreviewProvider {
    static var previews: some View {
        DemoPage2(title: .constant("This is a demo"))
    }
}
