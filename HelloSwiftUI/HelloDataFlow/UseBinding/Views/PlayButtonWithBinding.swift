//
//  PlayButtonWithBinding.swift
//  UseBinding
//
//  Created by wesley_chen on 2023/12/2.
//

import SwiftUI

struct PlayButtonWithBinding: View {
    @Binding var isPlaying: Bool // Play button now receives a binding.

    var body: some View {
        Button(isPlaying ? "Pause" : "Play") {
            isPlaying.toggle()
        }.border(.red)
    }
}

struct PlayButtonWithBinding_Previews: PreviewProvider {
    static var previews: some View {
        //PlayButtonWithBinding(isPlaying: false) // Error: Cannot convert value of type 'Bool' to expected argument type 'Binding<Bool>'
        
        // @see https://stackoverflow.com/questions/61853323/swiftui-cannot-convert-value-of-type-bool-to-expected-argument-type-binding
        PlayButtonWithBinding(isPlaying: .constant(false))
    }
}
