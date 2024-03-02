//
//  ShowThreeHikeGraphs.swift
//  AppTestTemplate
//
//  Created by wesley_chen on 2024/1/7.
//

import SwiftUI

struct ShowHikeView: View, DemoPage {
    var body: some View {
        let hike = getFirstHike()
        HikeView(hike: hike)
        Spacer()
    }
    
    // MARK: DemoPage
    static func createPage(withTitle title: Binding<String>) -> some View {
        ShowHikeView()
    }
}

#if swift(>=5.9)
#Preview {
    ShowHikeView()
}
#else
struct ShowThreeHikeGraphs_Previews: PreviewProvider {
    static var previews: some View {
        ShowThreeHikeGraphs()
    }
}
#endif
