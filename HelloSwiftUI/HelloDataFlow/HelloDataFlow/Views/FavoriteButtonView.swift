//
//  FavoriteButtonView.swift
//  HelloDataFlow
//
//  Created by wesley_chen on 2023/11/26.
//

import SwiftUI

struct FavoriteButtonView: View {
    @Binding var isSet: Bool

    var body: some View {
        Button {
            isSet.toggle()
        } label: {
            Label("Toggle Favorite", systemImage: isSet ? "star.fill" : "star")
                .labelStyle(.iconOnly)
                .foregroundStyle(isSet ? .yellow : .gray)
        }
    }
}

struct FavoriteButtonView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButtonView(isSet: .constant(true))
        //FavoriteButtonView()
    }
}
