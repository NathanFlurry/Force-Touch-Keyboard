//
//  Array+Magic.swift
//  Force Touch Keyboard
//
//  Created by Nathan Flurry on 10/27/16.
//  Copyright © 2016 Nathan Flurry. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
    mutating func remove(element: Element) {
        // Remove the value
        for (i, v) in enumerated() {
            if v == element {
                remove(at: i)
                break
            }
        }
    }
}
