//
//  SceneDelegate.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 30.10.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        
        Task {
//            await CloudKitManager.shared.addDiverseCategoriesUA()
//            await CloudKitManager.shared.addDiverseCategoriesEN()
            //            await CloudKitManager.shared.
//            try await CloudKitManager.shared.addCategoryToCloud(CategorySwiftModel(name: "Test2", level: 1, language: SupportedLanguages.english.rawValue))
//        }
//        Task {
//            try LocalDatabaseManager.shared.reloadSampleData()
            do {
                try await CloudKitManager.shared.syncCategories()
            } catch {
                print("Failed to sync categories: \(error)")
            }
            
            let vc = MainTabBarViewController()
            let navigationController = UINavigationController()
            navigationController.viewControllers = [vc]
            window?.rootViewController = navigationController
 
        }
    }
    
    
    func sceneDidDisconnect(_: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}
