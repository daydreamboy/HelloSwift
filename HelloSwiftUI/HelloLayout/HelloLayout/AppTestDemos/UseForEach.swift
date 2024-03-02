//
//  UseForEach.swift
//  AppTestTemplate
//
//  Created by wesley_chen on 2024/1/7.
//

import SwiftUI

struct UseForEach: View, DemoPage {
    @Binding var title: String
    
    private struct NamedFont: Identifiable {
        let name: String
        let font: Font
        var id: String { name }
    }

    private let namedFonts: [NamedFont] = [
        NamedFont(name: "Large Title", font: .largeTitle),
        NamedFont(name: "Title", font: .title),
        NamedFont(name: "Headline", font: .headline),
        NamedFont(name: "Body", font: .body),
        NamedFont(name: "Caption", font: .caption)
    ]

    var body: some View {
        ForEach(namedFonts) { namedFont in
            Text(namedFont.name)
                .font(namedFont.font)
        }
    }
    
    // MARK: DemoPage
    static func createPage(withTitle title: Binding<String>) -> some View {
        UseForEach.init(title: title)
    }
}

// Xcode15+
#if swift(>=5.9)
#Preview {
    UseForEach(title: .constant("This is a demo"))
}
#else
struct DemoPage1_Previews: PreviewProvider {
    static var previews: some View {
        UseForEach(title: .constant("This is a demo"))
    }
}
#endif
