//
//  UsePicker.swift
//  AppTestTemplate
//
//  Created by wesley_chen on 2024/1/7.
//

import SwiftUI

struct UsePicker: View, DemoPage {
    @Binding var title: String
    @State private var selectedSegment = 0

    var body: some View {
        Picker("Options", selection: $selectedSegment) {
            Text("First").tag(0)
            Text("Second").tag(1)
            Text("Third").tag(2)
        }
        .pickerStyle(.segmented)
        .padding()
        
        switch selectedSegment {
            case 0:
                Text("First Segment Selected")
            case 1:
                Text("Second Segment Selected")
            case 2:
                Text("Third Segment Selected")
            default:
                Text("None")
        }
    }
    
    // MARK: DemoPage
    static func createPage(withTitle title: Binding<String>) -> some View {
        UsePicker.init(title: title)
    }
}

#if swift(>=5.9)
#Preview {
    UsePicker(title: .constant("This is a demo"))
}
#else
struct DemoPage1_Previews: PreviewProvider {
    static var previews: some View {
        UsePicker(title: .constant("This is a demo"))
    }
}
#endif


