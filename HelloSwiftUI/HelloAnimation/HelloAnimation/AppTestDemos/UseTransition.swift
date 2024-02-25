//
//  UseRotationEffect.swift
//  AppTestTemplate
//
//  Created by wesley_chen on 2024/1/7.
//

import SwiftUI

extension Edge {
    var displayName: String {
        switch self {
            case .top:
                return "Top"
            case .leading:
                return "Leading"
            case .bottom:
                return "Bottom"
            case .trailing:
                return "Trailing"
        }
    }
}

struct UseTransition: View, DemoPage {
    @Binding var title: String
    @State private var toggleSlide = false
    @State private var toggleScale = false
    @State private var toggleOpacity = false
    @State private var toggleMove = false
    @State private var selectedEdge1: Edge = .top
    
    @State private var togglePush = false
    @State private var selectedEdge2: Edge = .top
    
    @State private var toggleOffset = false
    
    @State private var toggleCustomized = false

    var body: some View {
        ScrollView {
            // Case1: slide animation
            VStack {
                Button("Toggle slide animation") {
                    withAnimation(.easeInOut(duration: 2)) {
                        toggleSlide.toggle()
                    }
                }
                if toggleSlide {
                    Circle()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.blue)
                        .transition(.slide)
                } else {
                    Color.clear
                        .frame(height: 100)
                }
            }

            // Case2: scale animation
            VStack {
                Button("Toggle scale animation") {
                    withAnimation(.easeInOut(duration: 2)) {
                        toggleScale.toggle()
                    }
                }
                if toggleScale {
                    Circle()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.blue)
                        .transition(.scale)
                } else {
                    Color.clear
                        .frame(height: 100)
                }
            }
            
            // Case3: opacity animation
            VStack {
                Button("Toggle opacity animation") {
                    withAnimation(.easeInOut(duration: 2)) {
                        toggleOpacity.toggle()
                    }
                }
                if toggleOpacity {
                    Circle()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.blue)
                        .transition(.opacity)
                } else {
                    Color.clear
                        .frame(height: 100)
                }
            }
            
            // Case4: move animation
            VStack {
                Picker("Select an edge", selection: $selectedEdge1) {
                    ForEach(Edge.allCases, id: \.self) { edge in
                        Text("\(edge.displayName)").tag(edge)
                    }
                }.pickerStyle(.segmented)
            
                Button("Toggle move animation") {
                    withAnimation(.easeInOut(duration: 2)) {
                        toggleMove.toggle()
                    }
                }
                if toggleMove {
                    Circle()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.blue)
                        .transition(.move(edge: selectedEdge1))
                } else {
                    Color.clear
                        .frame(height: 100)
                }
            }
            
            // Case4: push animation
            if #available(iOS 16.0, *) {
                VStack {
                    Picker("Select an edge", selection: $selectedEdge2) {
                        ForEach(Edge.allCases, id: \.self) { edge in
                            Text("\(edge.displayName)").tag(edge)
                        }
                    }.pickerStyle(.segmented)
                
                    Button("Toggle push animation (iOS16+)") {
                        withAnimation(.easeInOut(duration: 2)) {
                            togglePush.toggle()
                        }
                    }
                    if togglePush {
                        Circle()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.blue)
                            .transition(.push(from: selectedEdge2))
                    } else {
                        Color.clear
                            .frame(height: 100)
                    }
                }
            } else {
                // do nothing here
            }
            
            // Case 5: offset animation
            VStack {
                Button("Toggle offset animation") {
                    withAnimation(.easeInOut(duration: 2)) {
                        toggleOffset.toggle()
                    }
                }
                if toggleOffset {
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: 100, height: 100)
                        .transition(.offset(CGSize(width: -100, height: 0)))
                    
                    // Note: .offset(x: -100, y: 0) is same as the .offset(CGSize(width: -100, height: 0))
                    Rectangle()
                        .fill(Color.orange)
                        .frame(width: 100, height: 100)
                        .transition(.offset(x: -100, y: 0))
                } else {
                    Color.clear
                        .frame(height: 100)
                    Color.clear
                        .frame(height: 100)
                }
            }
            
            // Case 6: create customized transition
            VStack {
                Button("Toggle customized animation") {
                    withAnimation(.easeInOut(duration: 2)) {
                        toggleCustomized.toggle()
                    }
                }
                if toggleCustomized {
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: 100, height: 100)
                        .transition(.asymmetric(
                            insertion: .offset(x: -200, y: 0),
                            removal: .offset(x: 200, y: 0)
                        ))
                    Rectangle()
                        .fill(Color.orange)
                        .frame(width: 100, height: 100)
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing).combined(with: .opacity),
                            removal: .scale.combined(with: .opacity)
                        ))
                } else {
                    Color.clear
                        .frame(height: 100)
                    Color.clear
                        .frame(height: 100)
                }
            }
        }
    }
    
    // MARK: DemoPage
    static func createPage(withTitle title: Binding<String>) -> some View {
        UseTransition.init(title: title)
    }
}

struct UseTransition_Previews: PreviewProvider {
    static var previews: some View {
        UseTransition(title: .constant("This is a demo"))
    }
}
