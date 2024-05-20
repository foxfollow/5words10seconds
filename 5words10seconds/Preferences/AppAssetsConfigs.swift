//
//  AppAssetsConfigs.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 11.05.2024.
//

import UIKit

enum AppAssetsConfigs {
    struct Colors {
        // MARK: Back
        static let backgroundTop: UIColor = {
            return UIColor { traitCollection in
                switch traitCollection.userInterfaceStyle {
                case .dark:
                    UIColor(hex: "#697D9A")
                default:
                    UIColor(hex: "#B1D0FF")
                }
            }
        }()
        
        static let backgroundBottom: UIColor = {
            return UIColor { traitCollection in
                switch traitCollection.userInterfaceStyle {
                case .dark:
                    UIColor(hex: "#3C495E")
                default:
                    UIColor(hex: "#4F79B7")
                }
            }
        }()
        
        static let cellBackground: UIColor = {
            return UIColor { traitCollection in
                switch traitCollection.userInterfaceStyle {
                case .dark:
                    UIColor(hex: "#1D1D2F", alpha: 0.8)
                default:
                    UIColor(hex: "#EAFFFC")
                }
            }
        }()
        
        static let tabBarTint: UIColor = {
            return UIColor { traitCollection in
                switch traitCollection.userInterfaceStyle {
                case .dark:
                    UIColor(hex: "#1D1D2F")
                default:
                    UIColor(hex: "#EAFFFC")
                }
            }
        }()
                
        static let trashTint: UIColor = UIColor(hex: "#7A008E")
        
        static let wordBackground: UIColor = {
            return UIColor { traitCollection in
                switch traitCollection.userInterfaceStyle {
                case .dark:
                    UIColor(hex: "#7A008E", alpha: 0.3)
                default:
                    UIColor(hex: "#EC74FF", alpha: 0.5)
                }
            }
        }()
        //UIColor(hex: "#7A008E", alpha: 0.3)
        static let timerBackground: UIColor = {
            return UIColor { traitCollection in
                switch traitCollection.userInterfaceStyle {
                case .dark:
                    UIColor(hex: "#240437", alpha: 0.7)
                default:
                    UIColor(hex: "#A91CFF", alpha: 0.7)
                }
            }
        }()
        
        static let buttonNeutral: UIColor = UIColor(hex: "#F0D36A", alpha: 0.4)
        static let buttonNeutralFull: UIColor = UIColor(hex: "#F0D36A")
        static let buttonAccept: UIColor = UIColor(hex: "#71EDED", alpha: 0.4)
        static let buttonAcceptFull: UIColor = UIColor(hex: "#71EDED")
        static let buttonReject: UIColor = UIColor(hex: "#ED7171", alpha: 0.4)
        
        // MARK: Text
        static let textMain: UIColor = {
            return UIColor { traitCollection in
                switch traitCollection.userInterfaceStyle {
                case .dark:
                    UIColor(hex: "#DADADA")
                default:
                    UIColor(hex: "#010049")
                }
            }
        }()
        
        static let textDescription: UIColor = {
            return UIColor { traitCollection in
                switch traitCollection.userInterfaceStyle {
                case .dark:
                    UIColor(hex: "#BEBEBE")
                default:
                    UIColor(hex: "#4B4B4B")
                }
            }
        }()
        
        static let textContrast: UIColor = {
            return UIColor { traitCollection in
                switch traitCollection.userInterfaceStyle {
                case .dark:
                    UIColor(hex: "#ffffff")
                default:
                    UIColor(hex: "#000000")
                }
            }
        }()
        
        static let textOpositeMain: UIColor = {
            return UIColor { traitCollection in
                switch traitCollection.userInterfaceStyle {
                case .dark:
                    UIColor(hex: "#010049")
                default:
                    UIColor(hex: "#DADADA")
                }
            }
        }()
        
        //MARK: Storke
        static let strokeAlert: UIColor = UIColor(hex: "#686686", alpha: 0.5)
        
        static let strokeButtons: UIColor = {
            return UIColor { traitCollection in
                switch traitCollection.userInterfaceStyle {
                case .dark:
                    UIColor(hex: "#C0C0C0")
                default:
                    UIColor(hex: "#000000")
                }
            }
        }()
    }
    
    struct Icons {
        static let game = UIImage(named: "gamepad")
        static let settings = UIImage(named: "settingshand")
        
        static let trash = UIImage(named: "delete") //UIImage(systemName: "trash.fill")
        
        static let plusNormal = UIImage(systemName: "plus.circle")
        static let plusHighlited = UIImage(systemName: "plus.square")
        static let minusNormal = UIImage(systemName: "minus.circle")
        static let minusHighlited = UIImage(systemName: "minus.square")
        
    }
}
