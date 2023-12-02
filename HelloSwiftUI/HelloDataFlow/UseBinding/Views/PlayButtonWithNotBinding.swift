//
//  PlayButtonWithNotBinding.swift
//  UseBinding
//
//  Created by wesley_chen on 2023/12/2.
//

import SwiftUI

struct PlayButtonWithNotBinding: View {
    @State var isPlaying: Bool // Play button with its own state

    var body: some View {
        Button(isPlaying ? "Pause" : "Play") {
            isPlaying.toggle()
        }.border(.red)
    }
}

struct PlayButtonWithNotBinding_Previews: PreviewProvider {
    static var previews: some View {
        PlayButtonWithNotBinding(isPlaying: false)
        //PlayButtonWithBinding(isPlaying: .constant(false))
    }
}
