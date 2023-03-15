//
//  WCSecurityTool.swift
//  HelloSecurity
//
//  Created by wesley_chen on 2022/4/26.
//

import UIKit
import CommonCrypto
// https://stackoverflow.com/a/67498866
class WCSecurityTool {
    class func encryptionAESModeECB(messageData data: Data, key: String) -> Data? {
        guard let keyData = key.data(using: String.Encoding.utf8) else { return nil }
        guard let cryptData = NSMutableData(length: Int((data.count)) + kCCBlockSizeAES128) else { return nil }
        
        let keyLength               = size_t(kCCKeySizeAES256)
        let keyDataM = NSMutableData.init(length: keyLength)
        keyDataM?.setData(keyData)
        keyDataM?.length = keyLength // fill zero
        
        let operation:  CCOperation = UInt32(kCCEncrypt)
        let algoritm:   CCAlgorithm = UInt32(kCCAlgorithmAES)
        let options:    CCOptions   = UInt32(kCCOptionECBMode + kCCOptionPKCS7Padding)
        let iv:         String      = ""
        
        var numBytesEncrypted: size_t = 0
        
        let cryptStatus = CCCrypt(operation,
                                  algoritm,
                                  options,
                                  (keyDataM?.copy() as! NSData).bytes, keyLength,
                                  //(keyData as NSData).bytes, keyLength,
                                  iv,
                                  (data as NSData).bytes, data.count,
                                  cryptData.mutableBytes, cryptData.length,
                                  &numBytesEncrypted)
        
        if UInt32(cryptStatus) == UInt32(kCCSuccess) {
            cryptData.length = Int(numBytesEncrypted)
            return cryptData.copy() as? Data
        } else {
            return nil
        }
    }
    
    class func encryptionAESModeECB_2(messageData data: Data, key: String) -> Data? {
        guard let keyData = key.data(using: String.Encoding.utf8) else { return nil }
        guard let cryptData = NSMutableData(length: Int((data.count)) + kCCBlockSizeAES128) else { return nil }
        
        let keyLength               = size_t(kCCKeySizeAES128)
        let operation:  CCOperation = UInt32(kCCEncrypt)
        let algoritm:   CCAlgorithm = UInt32(kCCAlgorithmAES)
        let options:    CCOptions   = UInt32(kCCOptionECBMode + kCCOptionPKCS7Padding)
        let iv:         String      = ""
        
        var numBytesEncrypted: size_t = 0
        
        let cryptStatus = CCCrypt(operation,
                                  algoritm,
                                  options,
                                  (keyData as NSData).bytes, keyLength,
                                  iv,
                                  (data as NSData).bytes, data.count,
                                  cryptData.mutableBytes, cryptData.length,
                                  &numBytesEncrypted)
        
        if UInt32(cryptStatus) == UInt32(kCCSuccess) {
            cryptData.length = Int(numBytesEncrypted)
            let encryptedString = cryptData.base64EncodedString(options: .lineLength64Characters)
            return encryptedString.data(using: .utf8)
        } else {
            return nil
        }
    }
}
