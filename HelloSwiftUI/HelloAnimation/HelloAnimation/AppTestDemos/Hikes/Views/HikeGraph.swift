//
//  HikeGraph.swift
//  HelloAnimation
//
//  Created by wesley_chen on 2024/1/8.
//

import SwiftUI

struct HikeGraph: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

func magnitude(of range: Range<Double>) -> Double {
    range.upperBound - range.lowerBound
}

struct HikeGraph_Previews: PreviewProvider {
    static var previews: some View {
        HikeGraph()
    }
}
