//
//  ListRowDetailView.swift
//  HelloNavigation
//
//  Created by wesley_chen on 2023/11/26.
//

import SwiftUI

struct ListRowDetailView: View {
    @EnvironmentObject var modelData: ModelData
    var landmark: ListItemLandmark
    
    var landmarkIndex: Int {
        modelData.landmarks.firstIndex(where: { $0.id == landmark.id })!
    }

    var body: some View {
        ScrollView {
            MapView(coordinate: landmark.locationCoordinate)
                .frame(height: 300)

            CircleImageView(image: landmark.image)
                .offset(y: -130)
                .padding(.bottom, -130)

            VStack(alignment: .leading) {
                HStack {
                    Text(landmark.name)
                        .font(.title)
                    FavoriteButtonView(isSet: $modelData.landmarks[landmarkIndex].isFavorite)
                }

                HStack {
                    Text(landmark.park)
                    Spacer()
                    Text(landmark.state)
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)

                Divider()

                Text("About \(landmark.name)")
                    .font(.title2)
                Text(landmark.description)
            }
            .padding()
        }
        .navigationTitle(landmark.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ListRowDetail_Previews: PreviewProvider {
    static var previews: some View {
        let landmarks = ModelData().landmarks
        ListRowDetailView(landmark: landmarks[0])
    }
}
