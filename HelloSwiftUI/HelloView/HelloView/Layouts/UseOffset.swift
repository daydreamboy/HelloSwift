//
//  UseOffset.swift
//  HelloView
//
//  Created by wesley_chen on 2024/1/8.
//

import SwiftUI

struct UseOffset: View {
    var body: some View {
        // Note: offset will keep original view occupied space,
        // so the others view aligned to the original view
        Text("Offset by passing horizontal & vertical distance")
            .border(Color.green)
            .offset(x: 20, y: 50)
            .border(Color.gray)
        Text("Text below the original view")
            .border(Color.red)
    }
}

#if swift(>=5.9)
#Preview {
    UseOffset()
}
#else
struct UseOffset_Previews: PreviewProvider {
    static var previews: some View {
        UseOffset()
    }
}
#endif

