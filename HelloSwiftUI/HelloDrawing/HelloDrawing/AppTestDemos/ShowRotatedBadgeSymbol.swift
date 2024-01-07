//
//  ShowRotatedBadgeSymbol.swift
//  HelloDrawing
//
//  Created by wesley_chen on 2024/1/7.
//

import SwiftUI

struct ShowRotatedBadgeSymbol: View, DemoPage {
    var body: some View {
        RotatedBadgeSymbol(angle: Angle(degrees: 5))
    }
    
    // MARK: DemoPage
    static func createPage(withTitle title: Binding<String>) -> some View {
        ShowRotatedBadgeSymbol()
    }
}

struct ShowRotatedBadgeSymbol_Previews: PreviewProvider {
    static var previews: some View {
        ShowRotatedBadgeSymbol()
    }
}
