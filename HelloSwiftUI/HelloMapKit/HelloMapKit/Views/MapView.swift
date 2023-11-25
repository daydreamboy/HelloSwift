//
//  MapView.swift
//  HelloMapKit
//
//  Created by wesley_chen on 2023/11/25.
//

import SwiftUI
import MapKit

struct MapView: View {
    // @see https://www.hackingwithswift.com/quick-start/swiftui/how-to-show-a-map-view
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166_868), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))

    var body: some View {
        Map(coordinateRegion: $region)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
