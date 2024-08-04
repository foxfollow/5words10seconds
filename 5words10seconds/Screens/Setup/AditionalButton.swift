//
//  AditionalButton.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 03.08.2024.
//

import UIKit

class AditionalButton:  UIButton {
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.alpha = 0.5
        super.touchesBegan(touches, with: event)
    }
    
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.alpha = 1
        super.touchesEnded(touches, with: event)
    }
    
    override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.alpha = 1
        super.touchesCancelled(touches, with: event)
    }
}
