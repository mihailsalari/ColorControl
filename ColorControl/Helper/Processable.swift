//
//  Processable.swift
//  ColorControl
//
//  Created by Mihail Șalari on 11/29/16.
//  Copyright © 2016 Mihail Șalari. All rights reserved.
//

import UIKit
import CoreImage
import Foundation

protocol Processable {
    
    var filter: CIFilter { get }
    var attributes: [String: Any] { get }
    
    func input(_ image: UIImage) -> Self
    func composite(_ processable: Processable) -> Self
    func outputCIImage() -> CIImage
    func outputCGImage() -> CGImage
    func outputUIImage() -> UIImage
    func inputDetailes(_ key: String) -> [String : Any]
    func minValue(inputKey key: String) -> Float
    func maxValue(inputKey key: String) -> Float
    func minValue(inputKey key: String) -> Int
    func maxValue(inputKey key: String) -> Int
}


extension Processable {

    var attributes: [String: Any] {
        get {
            self.filter.setDefaults()
            return self.filter.attributes as [String : Any]
        }
    }
}


extension Processable {
    
    func input(_ image: UIImage) -> Self {
        self.filter.setDefaults()
        guard let ciImage = CIImage(image: image) else { return self }
        self.filter.setValue(ciImage, forKey: kCIInputImageKey)
        
        return self
    }
    
    func composite(_ processable: Processable) -> Self {
        self.filter.setValue(processable.outputCIImage(), forKey: kCIInputImageKey)
        return self
    }
}

extension Processable {
    
    func outputCIImage() -> CIImage {
        guard let ciImage = self.filter.outputImage else {
            if let input = self.filter.value(forKey: kCIInputImageKey) as! CIImage? {
                return input
            } else {
                return CIImage.empty()
            }
        }
        return ciImage;
    }
    
    func outputCGImage() -> CGImage {
        guard let input = self.filter.value(forKey: kCIInputImageKey) as! CIImage? else {
            return UIImage().cgImage!
        }
        
        let context = CIContext(options: nil)
        return context.createCGImage(self.outputCIImage(), from: input.extent)!
    }
    
    func outputUIImage() -> UIImage {
        return UIImage(cgImage: self.outputCGImage())
    }
}



extension Processable {
    
    func inputDetailes(_ key: String) -> [String : Any] {
        return self.attributes[key] as! [String : Any]
    }
    
    func minValue(inputKey key: String) -> Float {
        return self.minNumber(inputKey: key).floatValue
    }
    
    func maxValue(inputKey key: String) -> Float {
        return self.maxNumber(inputKey: key).floatValue
    }
    
    func minValue(inputKey key: String) -> Int {
        return self.minNumber(inputKey: key).intValue
    }
    
    func maxValue(inputKey key: String) -> Int {
        return self.maxNumber(inputKey: key).intValue
    }
}


extension Processable {
    
    fileprivate func minNumber(inputKey key: String) -> NSNumber {
        let detailes = self.inputDetailes(key)
        if let min = detailes[kCIAttributeMin] as? NSNumber {
            return min
        }
        
        if let min = detailes[kCIAttributeSliderMin] as? NSNumber {
            return min
        }
        
        return NSNumber()
    }
    
    fileprivate func maxNumber(inputKey key: String) -> NSNumber {
        let detailes = self.inputDetailes(key)
        if let max = detailes[kCIAttributeMax] as? NSNumber {
            return max
        }
        
        if let max = detailes[kCIAttributeSliderMax] as? NSNumber {
            return max
        }
        
        return NSNumber()
    }
}
