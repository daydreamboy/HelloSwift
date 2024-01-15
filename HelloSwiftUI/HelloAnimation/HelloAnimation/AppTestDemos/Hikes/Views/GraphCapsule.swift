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
        let _ = print("height:\(height), heightRatio:\(heightRatio), offsetRatio:\(offsetRatio)")
        // Note: use negative offset y to shift view to top
//        Capsule()
//            .fill(color)
//            .frame(height: height * heightRatio)
//            .offset(x: 0, y: height * -offsetRatio)
        Capsule()
            .fill(color)
            .frame(height: height * heightRatio)
            .offset(x: 0, y: -100)
    }
}

#if swift(>=5.9)
#Preview {
    let hike = ModelData().hikes[0]
    let observations = hike.observations
    let overallRange = rangeOfRanges(observations.lazy.map { $0[keyPath: \.elevation] })
    let observation = hike.observations[7]
    
    let _ = print("overallRange:\(overallRange)")
    let _ = print("elevation:\(observation[keyPath: \.elevation])")
    
    return HStack(alignment: .bottom) {
        GraphCapsule(
            index: 0,
            color: .red,
            height: 200,
            range: observation[keyPath: \.elevation],
            overallRange: overallRange)
        GraphCapsule(
            index: 0,
            color: .green,
            height: 100,
            range: observation[keyPath: \.elevation],
            overallRange: overallRange)
        GraphCapsule(
            index: 0,
            color: .blue,
            height: 50,
            range: observation[keyPath: \.elevation],
            overallRange: overallRange)
        GraphCapsule(
            index: 0,
            color: .orange,
            height: 25,
            range: observation[keyPath: \.elevation],
            overallRange: overallRange)
        GraphCapsule(
            index: 0,
            color: .yellow,
            height: 10,
            range: observation[keyPath: \.elevation],
            overallRange: overallRange)
    }
    
//    GraphCapsule(
//        index: 0,
//        color: .blue,
//        height: 150,
//        range: 10..<50,
//        overallRange: 0..<100)

}
#else
struct GraphCapsule_Previews: PreviewProvider {
    static var previews: some View {
        GraphCapsule(index: 0, color: .blue, height: 150, range: 10..<50, overallRange: 0..<100)
    }
}
#endif

