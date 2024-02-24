//
//  UseRotationEffect.swift
//  AppTestTemplate
//
//  Created by wesley_chen on 2024/1/7.
//

import SwiftUI

struct UseWithAnimation: View, DemoPage {
    @Binding var title: String
    @State private var showSomeView = false
    @State private var isTransparent1 = false
    @State private var isTransparent2 = false
    @State private var showDetail1 = false
    @State private var showDetail2 = false

    var body: some View {
        VStack {
            // Case1: withAnimation will affect if clause, which affect layout
            Button("\(showSomeView ? "Hide" : "Show") View") {
                showSomeView.toggle()
            }
            Button("\(showSomeView ? "Hide" : "Show") View using withAnimation") {
                withAnimation(.easeInOut(duration: 2)) {
                    showSomeView.toggle()
                }
            }
            
            if showSomeView {
                Text("This view maybe hidden")
            }
            
            // Case2: withAnimation will affect all animatable properties
            HStack {
                VStack {
                    Circle()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.blue)
                        .opacity(isTransparent1 ? 0.0 : 1.0)
                    
                    Button("Toggle Opacity") {
                        isTransparent1.toggle()
                    }
                }
             
                VStack {
                    Circle()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.blue)
                        .opacity(isTransparent2 ? 0.0 : 1.0)
                    
                    Button("Toggle Opacity using withAnimation") {
                        withAnimation(.easeInOut(duration: 2)) {
                            isTransparent2.toggle()
                        }
                    }
                }
            }
            
            // Case 3: explictly disable animation using withAnimation(nil)
            HStack {
                Button {
                    withAnimation(nil) {
                        showDetail1.toggle()
                    }
                } label: {
                    Label("This is Button", systemImage: "chevron.right.circle")
                        .labelStyle(.iconOnly)
                        .imageScale(.large)
                        .rotationEffect(.degrees(showDetail1 ? 90 : 0))
                        .scaleEffect(showDetail1 ? 1.5 : 1)
                        .padding()
                }
                
                Button {
                    withAnimation {
                        showDetail2.toggle()
                    }
                } label: {
                    Label("This is Button", systemImage: "chevron.right.circle")
                        .labelStyle(.iconOnly)
                        .imageScale(.large)
                        .rotationEffect(.degrees(showDetail2 ? 90 : 0))
                        .scaleEffect(showDetail2 ? 1.5 : 1)
                        .padding()
                }
            }
        }
    }
    
    // MARK: DemoPage
    static func createPage(withTitle title: Binding<String>) -> some View {
        UseWithAnimation.init(title: title)
    }
}

struct UseWithAnimation_Previews: PreviewProvider {
    static var previews: some View {
        UseWithAnimation(title: .constant("This is a demo"))
    }
}
