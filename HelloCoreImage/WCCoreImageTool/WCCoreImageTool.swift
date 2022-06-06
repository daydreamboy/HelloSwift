//
//  WCCoreImageTool.swift
//  HelloCoreImage
//
//  Created by wesley_chen on 2022/6/6.
//

import Foundation
import AppKit

class WCCoreImageTool: NSObject {
    
    static func QRImage(_ string: String, _ size: NSSize, _ tintColor: NSColor?) -> NSImage? {

        let data = string.data(using: .utf8)
        let filter = CIFilter.init(name: "CIQRCodeGenerator")
        filter?.setValue(data, forKey: "inputMessage")
        filter?.setValue("H", forKey: "inputCorrectionLevel")
        
        var ciImage: CIImage = (filter?.outputImage)!
        
        let scaleX: Double = size.width / ciImage.extent.size.width;
        let scaleY: Double = size.height / ciImage.extent.size.height;

        ciImage = ciImage.transformed(by: CGAffineTransform.init(scaleX: scaleX, y: scaleY))
        
        if let tintColor = tintColor {
            repeat {
                let compositeFilter = CIFilter.init(name: "CIMultiplyCompositing")
                if ((compositeFilter == nil)) {
                    break;
                }
                
                let colorFilter = CIFilter.init(name: "CIConstantColorGenerator")
                if ((colorFilter == nil)) {
                    break;
                }
                
                if let newCiImage = invertColors(ciImage) {
                    ciImage = newCiImage
                }
                
                if let newCiImage = blackColorToTransparent(ciImage) {
                    ciImage = newCiImage
                }
                                
                let ciColor = CIColor.init(color: tintColor)
                colorFilter?.setValue(ciColor, forKey: kCIInputColorKey)

                let colorImage = colorFilter?.outputImage;

                compositeFilter?.setValue(colorImage, forKey: kCIInputImageKey)
                compositeFilter?.setValue(ciImage, forKey: kCIInputBackgroundImageKey)
                
                ciImage = (compositeFilter?.outputImage)!
            } while (false);
        }
        
        // @see https://stackoverflow.com/a/17386864
        let rep = NSCIImageRep(ciImage: ciImage)
        let nsImage = NSImage(size: rep.size)
        nsImage.addRepresentation(rep)
        
        return nsImage
    }
    
    static func invertColors(_ ciImage: CIImage) -> CIImage? {
        let filter = CIFilter.init(name: "CIColorInvert")
        if ((filter == nil)) {
            return nil;
        }
        
        filter?.setValue(ciImage, forKey: "inputImage")
        
        return filter?.outputImage;
    }
    
    static func blackColorToTransparent(_ ciImage: CIImage) -> CIImage? {
        let filter = CIFilter.init(name: "CIMaskToAlpha")
        if ((filter == nil)) {
            return nil;
        }
        
        filter?.setValue(ciImage, forKey: "inputImage")
        
        return filter?.outputImage;
    }
}
