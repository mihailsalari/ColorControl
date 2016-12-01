//
//  ColorControlManager.swift
//  ColorControl
//
//  Created by Mihail Șalari on 11/29/16.
//  Copyright © 2016 Mihail Șalari. All rights reserved.
//

import CoreImage

final class ColorControl: Brightnessable, Contrastable, Saturationable {
    
    // MARK: - Properties
    
    let filter = CIFilter(name: "CIColorControls")!
}
