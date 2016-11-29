//
//  Saturationable.swift
//  ColorControl
//
//  Created by Mihail Șalari on 11/29/16.
//  Copyright © 2016 Mihail Șalari. All rights reserved.
//

import Foundation
import CoreImage

protocol Saturationable: Processable {
    var minSaturationValue: Float { get }
    var maxSaturationValue: Float { get }
    var currentSaturationValue: Float { get }
    func saturation(_ saturation: Float) -> Self
}

extension Saturationable {
    
    var minSaturationValue: Float {
        return self.minValue(inputKey: kCIInputSaturationKey)
    }
    
    var maxSaturationValue: Float {
        return self.maxValue(inputKey: kCIInputSaturationKey)
    }
    
    var currentSaturationValue: Float {
        return filter.value(forKey: kCIInputSaturationKey) as! Float
    }
    
    func saturation(_ saturation: Float) -> Self {
        //        self.filter.setValue(NSNumber.floatNumber(saturation, min: self.minSaturationValue, max: self.maxSaturationValue), forKey: kCIInputSaturationKey)
        self.filter.setValue(saturation, forKey: kCIInputSaturationKey)
        
        return self
    }
}
