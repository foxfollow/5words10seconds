//
//  Extensions + UIColor.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 11.05.2024.
//

import UIKit

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

extension UIView {

    func setGradientBackground(_ toViews: UIView, topColor: UIColor, bottomColor: UIColor) {

        let colorTop =  topColor.cgColor
        let colorBottom = bottomColor.cgColor
                    
        toViews.layer.sublayers?.first(where: { $0 is CAGradientLayer })?.removeFromSuperlayer()

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = toViews.bounds
                
        toViews.layer.addSublayer(gradientLayer)
    }
    
    func setGradientBackground(toView: UIView, topColor: UIColor, bottomColor: UIColor) {

        let colorTop =  topColor.cgColor
        let colorBottom = bottomColor.cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = toView.bounds
                    
        if let oldLayer = toView.layer.sublayers?.first(where: { $0 is CAGradientLayer }) {
            oldLayer.removeFromSuperlayer()
        }
        toView.layer.insertSublayer(gradientLayer, at: 0)
    }
}
