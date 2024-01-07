//
//  ShowBadge.swift
//  HelloDrawing
//
//  Created by wesley_chen on 2024/1/7.
//

import SwiftUI

struct ShowBadge: View, DemoPage {
    var body: some View {
        Badge()
    }
    
    // MARK: DemoPage
    static func createPage(withTitle title: Binding<String>) -> some View {
        ShowBadge()
    }
}

struct ShowBadge_Previews: PreviewProvider {
    static var previews: some View {
        ShowBadge()
    }
}
