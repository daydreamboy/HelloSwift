//
//  ShowBadgeSymbol.swift
//  HelloDrawing
//
//  Created by wesley_chen on 2024/1/7.
//

import SwiftUI

struct ShowBadgeSymbol: View, DemoPage {
    var body: some View {
        BadgeSymbol()
    }
    
    // MARK: DemoPage
    static func createPage(withTitle title: Binding<String>) -> some View {
        ShowBadgeSymbol()
    }
}

struct ShowBadgeSymbol_Previews: PreviewProvider {
    static var previews: some View {
        ShowBadgeSymbol()
    }
}
