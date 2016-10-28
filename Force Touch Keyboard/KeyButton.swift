//
//  KeyButton.swift
//  Force Touch Keyboard
//
//  Created by Nathan Flurry on 10/27/16.
//  Copyright © 2016 Nathan Flurry. All rights reserved.
//

import UIKit

@IBDesignable
class KeyButton: UIView {
    // MARK: Parameters
    // Designable properties
    @IBInspectable var keyName: String {
        get {
            return titleLabel.text ?? ""
        }
        set {
            titleLabel.text = newValue
            titleLabel.sizeToFit()
        }
    }
    
    // Callback
    typealias KeyPressedCallback = (KeyButton) -> Void
    var keyPressCallback: KeyPressedCallback?
    
    // Properties
    let pressureThreshold: CGFloat = 0.6 // % of pressure needed to press the key
    let feedback = UIImpactFeedbackGenerator(style: .heavy)
    var pressedTouches: [UITouch] = []
    let idleBackground = UIColor.white
    let pressedBackground = UIColor.lightGray
    var previousPressedCount: Int = 0
    var isPressed: Bool {
        return pressedTouches.count > 0
    }
    
    // Views
    let titleLabel: UILabel = UILabel()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    private func setup() {
        // Make the view be able to have multiple fingers
        isMultipleTouchEnabled = true
        
        // Color the background
        backgroundColor = idleBackground
        
        // Setup the label
        addSubview(titleLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Center the label (because autolayout isn't playing well 😒)
        titleLabel.center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
    }
    
    // MARK: State management
    // Called the pressed touches are updated and manages events and state
    private func updatePressedState() {
        if previousPressedCount != pressedTouches.count {
            // Color the background
            backgroundColor = isPressed ? pressedBackground : idleBackground
            
            // Determine if to trigger the callback (if there's another pressed touch)
            if previousPressedCount < pressedTouches.count {
                keyPressCallback?(self)
            }
            
            // Save the press count
            previousPressedCount = pressedTouches.count
        }
    }
    
    // MARK: Touches
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Prepare the feedback
        feedback.prepare()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        var largestForce: CGFloat = 0 // Max force applied to the view
        for touch in touches {
            // Calculate the force properties
            let normalizedForce = touch.force / touch.maximumPossibleForce
            
            // Save the force if needed
            if normalizedForce > largestForce {
                largestForce = normalizedForce
            }
            
            // Press the touch, if needed
            if !pressedTouches.contains(touch) && normalizedForce >= pressureThreshold {
                // print("Press")
                
                // Create the press feedback
                feedback.impactOccurred()
                
                // Keep the feedback prepared for the next press
                feedback.prepare()
                
                // Save it's pressed
                pressedTouches.append(touch)
                updatePressedState()
            } else if pressedTouches.contains(touch) && normalizedForce < pressureThreshold {
                // print("Release")
                
                // Create the release feedback
                feedback.impactOccurred()
                
                // Keep the feedback prepared for the next press
                feedback.prepare()
                
                // Remove the touch
                pressedTouches.remove(element: touch)
                updatePressedState()
            }
        }
        
        // Color the view based on force
        // backgroundColor = idleBackground.blend(color: pressedBackground, time: largestForce)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Remove the touch
        for touch in touches {
            pressedTouches.remove(element: touch)
            updatePressedState()
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Remove the touch
        for touch in touches {
            pressedTouches.remove(element: touch)
            updatePressedState()
        }
    }
}
