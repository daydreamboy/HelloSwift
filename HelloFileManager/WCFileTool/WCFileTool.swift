//
//  WCFileTool.swift
//  HelloNSFileManager
//
//  Created by wesley_chen on 2023/11/5.
//

import Foundation

/**
 Get current file modification time
 
 - discusstion Place this code snippet in source swift code with caller
 */
fileprivate func currentFileTimestamp() -> String {
    do {
        let fileAttributes = try FileManager.default.attributesOfItem(atPath: #file)
        if let modificationDate = fileAttributes[.modificationDate] as? Date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let formattedDate = dateFormatter.string(from: modificationDate)
            return formattedDate
        }
    } catch {
    }
    return "Unkown time"
}