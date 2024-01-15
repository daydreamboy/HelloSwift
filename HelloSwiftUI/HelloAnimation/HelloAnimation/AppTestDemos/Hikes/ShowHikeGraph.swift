//
//  ShowHikeGraph.swift
//  AppTestTemplate
//
//  Created by wesley_chen on 2024/1/7.
//

import SwiftUI

struct ShowHikeGraph: View, DemoPage {
    var body: some View {
        if #available(iOS 17.0, *) {
            let _ = print("running on >= iOS17")
            let hike = ModelDataForiOS17().hikes[0]
            Group {
                HikeGraph(hike: hike, path: \.elevation)
                    .frame(height: 200)
                HikeGraph(hike: hike, path: \.heartRate)
                    .frame(height: 200)
                HikeGraph(hike: hike, path: \.pace)
                    .frame(height: 200)
            }
        } else {
            // Fallback on earlier versions
            let _ = print("running on iOS17-")
            let hike = ModelData().hikes[0]
            Group {
                HikeGraph(hike: hike, path: \.elevation)
                    .frame(height: 200)
                HikeGraph(hike: hike, path: \.heartRate)
                    .frame(height: 200)
                HikeGraph(hike: hike, path: \.pace)
                    .frame(height: 200)
            }
        }

    }
    
    // MARK: DemoPage
    static func createPage(withTitle title: Binding<String>) -> some View {
        ShowHikeGraph()
    }
}

struct ShowHikeGraph_Previews: PreviewProvider {
    static var previews: some View {
        ShowGraphCapsule()
    }
}
