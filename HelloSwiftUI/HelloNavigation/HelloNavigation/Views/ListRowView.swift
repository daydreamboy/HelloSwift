//
//  ListRowView.swift
//  HelloNavigation
//
//  Created by wesley_chen on 2023/11/26.
//

import SwiftUI

struct ListRowView: View {
    var landmark: ListItemLandmark

    var body: some View {
        HStack {
            landmark.image
                .resizable()
                .frame(width: 50, height: 50)
            Text(landmark.name)

            Spacer()
        }
    }

}

struct ListRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ListRowView(landmark: landmarks[0])
            ListRowView(landmark: landmarks[1])
        }
    }
}
