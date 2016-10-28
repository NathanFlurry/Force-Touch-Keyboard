//
//  UIColor+Magic.swift
//  Force Touch Keyboard
//
//  Created by Nathan Flurry on 10/27/16.
//  Copyright © 2016 Nathan Flurry. All rights reserved.
//

import UIKit

extension UIColor {
    var r: CGFloat {
        get {
            return extractColors()[0]
        }
    }
    var g: CGFloat {
        get {
            return extractColors()[1]
        }
    }
    var b: CGFloat {
        get {
            return extractColors()[2]
        }
    }
    var a: CGFloat {
        get {
            return extractColors()[3]
        }
    }
    
    func extractColors() -> [CGFloat] {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return [red, green, blue, alpha]
    }
    
    // Linearly blends the colors in RGB space
    func blend(color col: UIColor, time t: CGFloat) -> UIColor {
        return UIColor(
            red: r + (col.r - r) * t,
            green: g + (col.g - g) * t,
            blue: b + (col.b - b) * t,
            alpha: a + (col.a - a) * t
        )
    }
    
    func readableForegroundColorForBackgroundColor() -> UIColor {
        let darknessScore: CGFloat = (((r * 255) * 299) + ((g * 255) * 587) + ((b * 255) * 114)) / 1000
        
        if darknessScore > 125 {
            return UIColor.black
        } else {
            return UIColor.white
        }
    }
}

