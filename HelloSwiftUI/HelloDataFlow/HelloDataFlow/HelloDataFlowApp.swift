//
//  HelloDataFlowApp.swift
//  HelloDataFlow
//
//  Created by wesley_chen on 2023/11/26.
//

import SwiftUI

@main
struct HelloDataFlowApp: App {
    @State private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(modelData)
        }
    }
}