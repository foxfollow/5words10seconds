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
        
        let colorTop = topColor.cgColor
        let colorBottom = bottomColor.cgColor
        
        toViews.layer.sublayers?.first(where: { $0 is CAGradientLayer })?.removeFromSuperlayer()
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = toViews.bounds
        
        toViews.layer.addSublayer(gradientLayer)
    }
    
    func setGradientBackgroundWithoutAnimation(toView: UIView, topColor: UIColor, bottomColor: UIColor) {
        
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
    
    func setGradientBackground(toView: UIView, topColor: UIColor, bottomColor: UIColor) {
        let colorTop = topColor.cgColor
        let colorBottom = bottomColor.cgColor
        
        let gradientLayer: CAGradientLayer
        if let oldLayer = toView.layer.sublayers?.first(where: { $0 is CAGradientLayer }) as? CAGradientLayer {
            gradientLayer = oldLayer
        } else {
            gradientLayer = CAGradientLayer()
            toView.layer.insertSublayer(gradientLayer, at: 0)
        }
        
        gradientLayer.frame = toView.bounds
        gradientLayer.locations = [0.0, 1.0]
        
        let animation = CABasicAnimation(keyPath: "colors")
        animation.fromValue = gradientLayer.colors
        animation.toValue = [colorTop, colorBottom]
        animation.duration = 1.0
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        gradientLayer.colors = [colorTop, colorBottom]
        CATransaction.commit()
        
        gradientLayer.add(animation, forKey: nil)
    }
}

extension UIImage {
    func resizeImage(targetSize: CGSize) -> UIImage {
        let size = self.size

        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height

        let newSize = widthRatio > heightRatio ? CGSize(width: size.width * heightRatio, height: size.height * heightRatio) : CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
}
