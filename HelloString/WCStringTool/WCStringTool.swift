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
    
    // MARK: Check range/NSRange safe
    
    // @see https://stackoverflow.com/a/58603816
    static func hasNSRangeWithString(_ string: String, _ range: NSRange) -> Bool {
        return Range(range, in: string) != nil
    }
    
    // @see https://stackoverflow.com/a/39553998
    static func hasRangeWithString(_ string: String, _ range: Range<String.Index>) -> Bool {
        return range.clamped(to: string.startIndex..<string.endIndex) == range
    }
    
    // @see https://stackoverflow.com/a/30404532
    static func NSRangeFromRangeWithString(_ string: String, from range: Range<String.Index>) -> NSRange {
        let from = range.lowerBound.samePosition(in: string.utf16)
        let to = range.upperBound.samePosition(in: string.utf16)
        return NSRange(location: string.utf16.distance(from: string.utf16.startIndex, to: from!),
                       length: string.utf16.distance(from: from!, to: to!))
    }
    
    // @see https://stackoverflow.com/a/30404532
    static func rangeFromNSRangeWithString(_ string: String, from nsRange: NSRange) -> Range<String.Index>? {
        guard
            let from16 = string.utf16.index(string.utf16.startIndex, offsetBy: nsRange.location, limitedBy: string.utf16.endIndex),
            let to16 = string.utf16.index(string.utf16.startIndex, offsetBy: nsRange.location + nsRange.length, limitedBy: string.utf16.endIndex),
            let from = from16.samePosition(in: string),
            let to = to16.samePosition(in: string)
            else { return nil }
        return from ..< to
    }
    
    static func stringWithFileName(fileName: String, bundle: Bundle = Bundle.main) -> String? {
        let newFileName: NSString = fileName as NSString
        
        // @see https://stackoverflow.com/a/26707509
        let type = newFileName.pathExtension
        let name = newFileName.deletingPathExtension
        
        if let path = bundle.path(forResource: name, ofType: type) {
            var source: String?
            do {
                source = try String.init(contentsOfFile: path)
                
                return source
            } catch  {
                #if DEBUG
                print(error)
                #endif
            }
        }
        
        return nil
    }
    
    // MARK: String to File
    
    /// Write string to file under the temporary folder
    /// - Parameters:
    ///   - string: the content of the file
    ///   - fileName: the file name. Pass nil use a UUID string. Default is nil
    ///   - ext: the extension of the file. If fileName not nil, will not append the ext. Default is nil
    ///   - atomically: atomically flag. Default is true
    ///   - encoding: the text encoding. Default is UTF8
    /// - Returns: the file URL if write successfully. Return nil if write failed
    static func writeStringToTempFolder(string: String, fileName: String? = nil, ext: String? = nil, atomically: Bool = true, encoding: String.Encoding = .utf8) -> URL? {
        let newFileName = fileName ?? UUID.init().uuidString.appending(ext == nil ? "" : String.init(".\(ext!)"))
        let fileURL: URL = FileManager.default.temporaryDirectory.appendingPathComponent(newFileName, isDirectory: false)
        do {
            try string.write(to: fileURL, atomically: atomically, encoding: encoding)
            return fileURL
        } catch  {
            return nil
        }
    }
    
    // MARK: Regex Match
    
    
    /// Get the matched strings or the strings from capture groups
    /// - Parameters:
    ///   - string: the original string
    ///   - pattern: the pattern
    /// - Returns: the matched strings or the strings from capture groups
    static func matchedStringWithString(string: String, pattern: String) -> [String]? {
        if pattern.range(of: "(") != nil && pattern.range(of: ")") != nil {
            do {
                var matchedStrings: [String] = []
                let regex = try NSRegularExpression(pattern: pattern)
                let matches: [NSTextCheckingResult] = regex.matches(in: string, range: NSRange(string.startIndex..., in: string))
                for match in matches {
                    for i in (1..<match.numberOfRanges) {
                        let rangeBounds = match.range(at: i)
                        if let range = Range(rangeBounds, in: string) {
                            // Note: https://stackoverflow.com/a/46617119
                            matchedStrings.append(String(string[range]))
                        }
                    }
                }
                
                return matchedStrings
            } catch let error {
                #if DEBUG
                print("invalid regex: \(error.localizedDescription)")
                #endif
                return []
            }
        }
        else {
            do {
                var matchedStrings: [String] = []
                let regex = try NSRegularExpression(pattern: pattern)
                let matches: [NSTextCheckingResult] = regex.matches(in: string, range: NSRange(string.startIndex..., in: string))
                for match in matches {
                    let rangeBounds = match.range(at: 0)
                    if let range = Range(rangeBounds, in: string) {
                        matchedStrings.append(String(string[range]))
                    }
                }
                
                return matchedStrings
            } catch let error {
                #if DEBUG
                print("invalid regex: \(error.localizedDescription)")
                #endif
                return []
            }
        }
    }
}
