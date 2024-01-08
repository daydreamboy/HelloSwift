//
//  GraphCapsule.swift
//  HelloAnimation
//
//  Created by wesley_chen on 2024/1/8.
//

import SwiftUI

struct GraphCapsule: View, Equatable {
    var index: Int
    var color: Color
    var height: CGFloat
    var range: Range<Double>
    var overallRange: Range<Double>
    
    var heightRatio: CGFloat {
        max(CGFloat(magnitude(of: range) / magnitude(of: overallRange)), 0.15)
    }
    
    var offsetRatio: CGFloat {
        CGFloat((range.lowerBound - overallRange.lowerBound) / magnitude(of: overallRange))
    }
    
    var body: some View {
        Capsule()
            .fill(color)
            .frame(height: height * heightRatio)
            .offset(x: 0, y: height * -offsetRatio)
    }
}

#if swift(>=5.9)
#Preview {
    GraphCapsule(
        index: 0,
        color: .blue,
        height: 150,
        range: 10..<50,
        overallRange: 0..<100)
}
#else
struct GraphCapsule_Previews: PreviewProvider {
    static var previews: some View {
        GraphCapsule(index: 0, color: .blue, height: 150, range: 10..<50, overallRange: 0..<100)
    }
}
#endif

