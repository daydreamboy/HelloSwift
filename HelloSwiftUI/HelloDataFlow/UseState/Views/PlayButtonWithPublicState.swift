//
//  PlayButtonWithPublicState.swift
//  UseState
//
//  Created by wesley_chen on 2023/12/2.
//

import SwiftUI

struct PlayButtonWithPublicState: View {
    @State var isPlaying: Bool // Create the state.

    var body: some View {
        Button(isPlaying ? "Pause" : "Play") { // Read the state.
            isPlaying.toggle() // Write the state.
        }.border(.red)
    }
}

struct PlayButtonWithPublicState_Previews: PreviewProvider {
    static var previews: some View {
        PlayButtonWithPublicState(isPlaying: true)
    }
}
