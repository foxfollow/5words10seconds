//
//  MainTabBarViewController.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 20.05.2024.
//

import UIKit

final class MainTabBarViewController: UITabBarController {
    
    let menuVC: MenuViewController = MenuViewController()
    let setupVC: SetupViewController = SetupViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.isMultipleTouchEnabled = false
        self.tabBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        contentReady()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        var newFrame = tabBar.frame
        newFrame.size.height = 110
        newFrame.origin.y = view.frame.size.height - 110
        tabBar.frame = newFrame
    }
    

    func configViewControllers() {
        let size = CGSize(width: 40, height: 40)
        
        let menuBar = AppAssetsConfigs.Icons.game
        menuVC.tabBarItem = UITabBarItem(title: "Game", image: menuBar, tag: 0)
        menuVC.tabBarItem.image = menuBar?.resizeImage(targetSize: size)
        menuVC.tabBarItem.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 16)], for: .normal)
        
        let setupBar = AppAssetsConfigs.Icons.settings
        setupVC.tabBarItem = UITabBarItem(title: "How To Play", image: setupBar, tag: 1)
        setupVC.tabBarItem.image = setupBar?.resizeImage(targetSize: size)
        setupVC.tabBarItem.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 16)], for: .normal)

        if UIDevice.current.userInterfaceIdiom == .pad {
            let titleOffset: UIOffset = UIOffset(horizontal: 0, vertical: -24)
            menuVC.tabBarItem.titlePositionAdjustment = titleOffset
            setupVC.tabBarItem.titlePositionAdjustment = titleOffset
        }

        self.viewControllers = [menuVC, setupVC]
    }
    
    func configureTabBar() {
        self.tabBar.tintColor = AppAssetsConfigs.Colors.textContrast
        self.tabBar.unselectedItemTintColor = AppAssetsConfigs.Colors.textDescription
        self.tabBar.backgroundColor = AppAssetsConfigs.Colors.tabBarTint
        self.tabBar.isTranslucent = false
        self.tabBar.layer.shadowOpacity = 0
    }
}

extension MainTabBarViewController {
    func contentReady() {
        self.tabBar.isHidden = false

        configureTabBar()
        configViewControllers()
    }
}
