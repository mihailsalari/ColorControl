//
//  Contrastable.swift
//  ColorControl
//
//  Created by Mihail Șalari on 11/29/16.
//  Copyright © 2016 Mihail Șalari. All rights reserved.
//

import Foundation
import CoreImage

protocol Contrastable: Processable {
    var minContrastValue: Float { get }
    var maxContrastValue: Float { get }
    var currentContrastValue: Float { get }
    func contrast(_ contrast: Float) -> Self
}

extension Contrastable {
    
    var minContrastValue: Float {
        return self.minValue(inputKey: kCIInputContrastKey)
    }
    
    var maxContrastValue: Float {
        return self.minValue(inputKey: kCIInputContrastKey)
    }
    
    var currentContrastValue: Float {
        return filter.value(forKey: kCIInputContrastKey) as! Float
    }
    
    func contrast(_ contrast: Float) -> Self {
        self.filter.setValue(NSNumber.floatNumber(contrast, min: self.minContrastValue, max: self.maxContrastValue), forKey: kCIInputContrastKey)
//        self.filter.setValue(contrast, forKey: kCIInputContrastKey)
        
        return self
    }
}
