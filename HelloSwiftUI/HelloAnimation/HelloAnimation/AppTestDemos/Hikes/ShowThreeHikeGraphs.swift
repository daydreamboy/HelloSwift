//
//  ShowThreeHikeGraphs.swift
//  AppTestTemplate
//
//  Created by wesley_chen on 2024/1/7.
//

import SwiftUI

struct ShowThreeHikeGraphs: View, DemoPage {
    var body: some View {
        let hike = getFirstHike()
        Group {
            // Note: add border to debug UI
            HikeGraph(hike: hike, path: \.elevation)
                .frame(height: 200)
                .border(.red)
            HikeGraph(hike: hike, path: \.heartRate)
                .frame(height: 200)
                .border(.red)
            HikeGraph(hike: hike, path: \.pace)
                .frame(height: 200)
                .border(.red)
        }
    }
    
    // MARK: DemoPage
    static func createPage(withTitle title: Binding<String>) -> some View {
        ShowThreeHikeGraphs()
    }
}

#if swift(>=5.9)
#Preview {
    ShowThreeHikeGraphs()
}
#else
struct ShowThreeHikeGraphs_Previews: PreviewProvider {
    static var previews: some View {
        ShowThreeHikeGraphs()
    }
}
#endif
