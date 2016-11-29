//
//  Brightnessable.swift
//  ColorControl
//
//  Created by Mihail Șalari on 11/29/16.
//  Copyright © 2016 Mihail Șalari. All rights reserved.
//

import Foundation
import CoreImage

protocol Brightnessable: Processable {
    var minBrightnessValue: Float { get }
    var maxBrightnessValue: Float { get }
    var currentBrightnessValue: Float { get }
    func brightness(_ brightness: Float) -> Self
}


extension Brightnessable {
    
    var minBrightnessValue: Float {
        return self.minValue(inputKey: kCIInputBrightnessKey)
    }
    
    var maxBrightnessValue: Float {
        return self.maxValue(inputKey: kCIInputBrightnessKey)
    }
    
    var currentBrightnessValue: Float {
        return filter.value(forKey: kCIInputBrightnessKey) as! Float
    }
    
    func brightness(_ brightness: Float) -> Self {
        ///self.filter.setValue(NSNumber.floatNumber(brightness, min: self.minBrightnessValue, max: self.maxBrightnessValue), forKey: kCIInputBrightnessKey)
        self.filter.setValue(brightness, forKey: kCIInputBrightnessKey)
        
        return self
    }
}
