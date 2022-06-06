//
//  WCStringTool.swift
//  HelloString
//
//  Created by wesley_chen on 2022/6/6.
//

import Foundation

class WCStringTool: NSObject {
    static func URLEscapedString(_ string: String) -> String? {
        let kAFCharactersGeneralDelimitersToEncode: String = ":#[]@?/"; // Note: RFC 3986 - Section 3.4 does not include "?" or "/"
        let kAFCharactersSubDelimitersToEncode: String = "!$&'()*+,;=";
        
        var charactersToRemove = String.init()
        charactersToRemove.append(kAFCharactersGeneralDelimitersToEncode)
        charactersToRemove.append(kAFCharactersSubDelimitersToEncode)
        
        var allowedCharacterSet: CharacterSet = CharacterSet.urlQueryAllowed
        allowedCharacterSet.remove(charactersIn: charactersToRemove)
        
        let escapedString: String? = string.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet)
        
        return escapedString
    }
}
