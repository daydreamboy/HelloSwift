//
//  CircleImageView.swift
//  HelloNavigation
//
//  Created by wesley_chen on 2023/11/26.
//

import SwiftUI

struct CircleImageView: View {
    var image: Image

    var body: some View {
        image.clipShape(Circle())
            .overlay {
                Circle().stroke(.white, lineWidth: 4)
            }
            .shadow(radius: 7)
    }
}

struct CircleImageView_Previews: PreviewProvider {
    static var previews: some View {
        CircleImageView(image: Image("turtlerock"))
    }
}
