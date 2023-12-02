//
//  PlayerView.swift
//  UseBinding
//
//  Created by wesley_chen on 2023/12/2.
//

import SwiftUI

struct PlayerView: View {
    @State private var isPlaying: Bool = false // Create the state here now.

    var body: some View {
        VStack {
            PlayButtonWithBinding(isPlaying: $isPlaying) // Pass a binding.
            PlayButtonWithNotBinding(isPlaying: isPlaying ? true : false) // Not pass a binding.
        }
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView()
    }
}
