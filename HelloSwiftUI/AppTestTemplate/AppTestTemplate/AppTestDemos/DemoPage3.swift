//
//  DemoPage3.swift
//  AppTestTemplate
//
//  Created by wesley_chen on 2024/1/7.
//

import SwiftUI

struct DemoPage3: View, DemoPage {
    @Binding var title: String

    var body: some View {
        Text("This is demo3")
    }
    
    // MARK: DemoPage
    static func createPage(withTitle title: Binding<String>) -> some View {
        DemoPage3.init(title: title)
    }
}

// Xcode15+
#if swift(>=5.9)
#Preview {
    DemoPage3(title: .constant("This is a demo"))
}
#else
struct DemoPage3_Previews: PreviewProvider {
    static var previews: some View {
        DemoPage3(title: .constant("This is a demo"))
    }
}
#endif
