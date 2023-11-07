//
//  WCApplicationTool.swift
//  HelloUIApplication
//
//  Created by wesley_chen on 2023/11/7.
//

import Foundation

class WCApplicationTool: NSObject {
    static func appDocumentsDirectory() -> URL {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documentDirectory;
    }
}
