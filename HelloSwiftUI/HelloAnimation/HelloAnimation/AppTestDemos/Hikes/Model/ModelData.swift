//
//  ModelData.swift
//  HelloAnimation
//
//  Created by wesley_chen on 2024/1/8.
//

import Foundation

// Note: make two same ModelData for different target OS
// iOS 17+, use ModelDataForiOS17
// iOS 17-, use ModelData
@available(iOS 17.0, *)
@Observable
class ModelDataForiOS17 {
    var hikes: [Hike] = load("hikeData.json")
}
class ModelData: ObservableObject {
    var hikes: [Hike] = load("hikeData.json")
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
