//
//  RootViewController.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 16.05.2024.
//

import UIKit

class RootViewController: UIViewController {
    static var currentTheme: UIUserInterfaceStyle?

    override func viewDidLoad() {
        super.viewDidLoad()

        if RootViewController.currentTheme == nil {
            RootViewController.currentTheme = traitCollection.userInterfaceStyle
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupBaseColorWithoutAnimation()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if traitCollection.userInterfaceStyle != RootViewController.currentTheme {
            RootViewController.currentTheme = traitCollection.userInterfaceStyle
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                UIView.animate(withDuration: 2.5) {
                    self.setupBaseColor()
                }
            }
        }
    }

    func setupBaseColor() {
        view.setGradientBackground(toView: view, topColor: AppAssetsConfigs.Colors.backgroundTop, bottomColor: AppAssetsConfigs.Colors.backgroundBottom)
    }

    func setupBaseColorWithoutAnimation() {
        view.setGradientBackgroundWithoutAnimation(toView: view, topColor: AppAssetsConfigs.Colors.backgroundTop, bottomColor: AppAssetsConfigs.Colors.backgroundBottom)
    }
}
