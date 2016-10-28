//
//  ViewController.swift
//  Force Touch Keyboard
//
//  Created by Nathan Flurry on 10/27/16.
//  Copyright © 2016 Nathan Flurry. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // References
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var keyButtons: [KeyButton]!
    var shiftButtons: [KeyButton] = []
    
    // Parameters
    var isShifting: Bool { // Return if the keys are shifting
        for button in shiftButtons {
            if button.isPressed {
                return true
            }
        }
        return false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for button in keyButtons {
            // Set the callback
            button.keyPressCallback = handleKeyPressed
            
            // Save it if it's a shift
            if button.keyName == "shift" {
                shiftButtons.append(button)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        print("RIP")
    }

    func handleKeyPressed(_ keyButton: KeyButton) {
        // Do something with the text
        switch keyButton.keyName {
        case "shift": // Shift does nothing
            break
        case "delete":
            // Delete the last character if there's any text
            if textView.text.characters.count > 0 {
                textView.text = textView.text.substring(to: textView.text.index(before: textView.text.endIndex))
            }
            
            // Scroll to bottom
            textView.scrollToBottom(animated: true)
        case "return":
            // Enter a new line
            append(text: "\n")
        default:
            // Append text that's uppercased if needed
            append(text: isShifting ? keyButton.keyName.uppercased() : keyButton.keyName.lowercased())
        }
    }
    
    func append(text: String) {
        // Add the text
        textView.text = textView.text + text
        
        // Scroll to the bottom to see what was typed
        textView.scrollToBottom(animated: true)
    }

}

