//
//  ShowBadgeBackground.swift
//  HelloDrawing
//
//  Created by wesley_chen on 2024/1/7.
//

import SwiftUI

struct ShowBadgeBackground: View, DemoPage {
    var body: some View {
        BadgeBackground()
    }
    
    // MARK: DemoPage
    static func createPage(withTitle title: Binding<String>) -> some View {
        ShowBadgeBackground()
    }
}

struct ShowBadgeBackground_Previews: PreviewProvider {
    static var previews: some View {
        ShowBadgeBackground()
    }
}
