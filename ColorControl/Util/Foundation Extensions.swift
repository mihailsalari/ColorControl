//
//  Foundation Extensions.swift
//  ColorControl
//
//  Created by Mihail Șalari on 11/29/16.
//  Copyright © 2016 Mihail Șalari. All rights reserved.
//

import Foundation

// MARK: - NSNumber

extension NSNumber {
    
    static func doubleNumber(_ double: Double, min: Double, max: Double) -> NSNumber {
        return NSNumber(value: self.convert(double, min: min, max: max))
    }
    
    static func floatNumber(_ floatNr: Float, min: Float, max: Float) -> NSNumber {
        return NSNumber(value: self.convert(floatNr, min: min, max: max))
    }
    
    static func intNumber(_ int: Int, min: Int, max: Int) -> NSNumber {
        return NSNumber(value: self.convert(int, min: min, max: max) as Int)
    }
    
    fileprivate static func convert<T: Comparable>(_ target: T, min: T, max: T) -> T {
        if target < min {
            return min
        }
        
        if target > max {
            return max
        }
        
        return target
    }
}
