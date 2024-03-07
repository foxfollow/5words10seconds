//
//  BlurOverlayView.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 03.03.2024.
//

import UIKit

class BlurOverlayFactorView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupVisualEffectView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupVisualEffectView()
    }
    
    private func setupVisualEffectView() {
        let blurEffect = UIBlurEffect(style: .systemChromeMaterialDark)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.frame = self.bounds
        visualEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] 
        visualEffectView.alpha = 0.6
        self.addSubview(visualEffectView)
    }
    
    public func addAlert(alertView: AlertView, isAnimated: Bool = true) {

            

        self.addSubview(alertView)
        if isAnimated {
            self.alpha = 0
            UIView.animate(withDuration: 0.3) {
                self.alpha = 1
            }
        }
    }
    
    public func addAlert(alertView: AlertCollectionView, isAnimated: Bool = true) {

            

        self.addSubview(alertView)
        if isAnimated {
            self.alpha = 0
            UIView.animate(withDuration: 0.3) {
                self.alpha = 1
            }
        }
    }

}
