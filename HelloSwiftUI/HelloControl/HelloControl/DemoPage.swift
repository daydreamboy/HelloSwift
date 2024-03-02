//
//  DemoPage.swift
//  AppTestTemplate
//
//  Created by wesley_chen on 2024/1/7.
//

import SwiftUI

protocol DemoPage: View {
    associatedtype PageBody: View
    static func createPage(withTitle title: Binding<String>) -> PageBody
}
