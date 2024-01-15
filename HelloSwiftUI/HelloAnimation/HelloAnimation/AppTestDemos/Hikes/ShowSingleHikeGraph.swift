//
//  ShowSingleHikeGraph.swift
//  HelloAnimation
//
//  Created by wesley_chen on 2024/1/15.
//

import SwiftUI

struct ShowSingleHikeGraph: View, DemoPage {
    var body: some View {
        let hike = getFistHike()
        Group {
            // Note: add border to debug UI
            HikeGraph(hike: hike, path: \.pace)
                .frame(height: 200)
                .border(.red)
        }
    }
    
    // MARK: DemoPage
    static func createPage(withTitle title: Binding<String>) -> some View {
        ShowSingleHikeGraph()
    }
}

#if swift(>=5.9)
#Preview {
    ShowSingleHikeGraph()
}
#else
struct ShowThreeHikeGraphs_Previews: PreviewProvider {
    static var previews: some View {
        ShowThreeHikeGraphs()
    }
}
#endif
