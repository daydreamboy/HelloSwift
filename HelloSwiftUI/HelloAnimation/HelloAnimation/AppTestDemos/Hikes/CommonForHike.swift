//
//  CommonForHike.swift
//  HelloAnimation
//
//  Created by wesley_chen on 2024/1/15.
//

import Foundation

func getFirstHike() -> Hike {
    if #available(iOS 17.0, *) {
        let _ = print("running on >= iOS17")
        return ModelDataForiOS17().hikes[0]
    } else {
        // Fallback on earlier versions
        let _ = print("running on iOS17-")
        return ModelData().hikes[0]
    }
}

