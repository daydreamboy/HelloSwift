//
//  PlayButtonWithPrivateState.swift
//  UseState
//
//  Created by wesley_chen on 2023/12/2.
//

import SwiftUI

struct PlayButtonWithPrivateState: View {
    @State private var isPlaying: Bool = false // Create the state.

    var body: some View {
        Button(isPlaying ? "Pause" : "Play") { // Read the state.
            isPlaying.toggle() // Write the state.
        }.border(.red)
    }
}

struct PlayButton_Previews: PreviewProvider {
    static var previews: some View {
        PlayButtonWithPrivateState()
    }
}
