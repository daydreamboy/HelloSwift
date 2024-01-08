//
//  UseOffset.swift
//  HelloView
//
//  Created by wesley_chen on 2024/1/8.
//

import SwiftUI

struct UseOffset: View {
    var body: some View {
        Text("Offset by passing horizontal & vertical distance")
            .border(Color.green)
            .offset(x: 20, y: 50)
            .border(Color.gray)
    }
}

struct UseOffset_Previews: PreviewProvider {
    static var previews: some View {
        UseOffset()
    }
}
