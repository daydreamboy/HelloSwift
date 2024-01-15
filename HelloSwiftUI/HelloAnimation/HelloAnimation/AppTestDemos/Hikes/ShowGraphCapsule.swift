//
//  ShowGraphCapsule.swift
//  HelloAnimation
//
//  Created by wesley_chen on 2024/1/11.
//

import SwiftUI

struct ShowGraphCapsule: View, DemoPage {
    var body: some View {
        GraphCapsule(index: 0, color: .blue, height: 150, range: 10..<50, overallRange: 0..<100)
    }
    
    // MARK: DemoPage
    static func createPage(withTitle title: Binding<String>) -> some View {
        ShowGraphCapsule()
    }
}

#Preview {
    ShowGraphCapsule()
}
