//
//  ContentView.swift
//  UseState
//
//  Created by wesley_chen on 2023/12/2.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            PlayButtonWithPrivateState()
            PlayButtonWithPublicState(isPlaying: true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
