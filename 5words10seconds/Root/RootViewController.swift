//
//  RootViewController.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 16.05.2024.
//

import UIKit

class RootViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


        setupBaseColor()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            setupBaseColor()
        }
    }
    func setupBaseColor() {
        view.setGradientBackground(toView: self.view, topColor: AppAssetsConfigs.Colors.backgroundTop, bottomColor: AppAssetsConfigs.Colors.backgroundBottom)
    }
    
    
}
