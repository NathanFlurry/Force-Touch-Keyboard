//
//  UIScrollView+Magic.swift
//  Force Touch Keyboard
//
//  Created by Nathan Flurry on 10/28/16.
//  Copyright © 2016 Nathan Flurry. All rights reserved.
//

import UIKit

extension UIScrollView {
    /// Scrolls to the bottom of a UIScrollView. Does not work with horizontal sliding scroll views.
    func scrollToBottom(animated: Bool) {
        scrollRectToVisible(
            CGRect(
                x: contentSize.width - 1,
                y: contentSize.height - 1,
                width: 1, height: 1
            ),
            animated: animated
        )
    }
}
