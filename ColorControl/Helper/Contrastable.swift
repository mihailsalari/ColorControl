//
//  Contrastable.swift
//  ColorControl
//
//  Created by Mihail Șalari on 11/29/16.
//  Copyright © 2016 Mihail Șalari. All rights reserved.
//

import CoreImage

protocol Contrastable: Processable {
    var minContrastValue: Float { get }
    var maxContrastValue: Float { get }
    var currentContrastValue: Float { get }
    func contrast(_ contrast: Float)
}

extension Contrastable {
    
    var minContrastValue: Float {
        return 0.00
    }
    
    var maxContrastValue: Float {
        return 4.00
    }
    
    var currentContrastValue: Float {
        return filter.value(forKey: kCIInputContrastKey) as? Float ?? 1.00
    }
    
    func contrast(_ contrast: Float) {
        self.filter.setValue(contrast, forKey: kCIInputContrastKey)
    }
}
