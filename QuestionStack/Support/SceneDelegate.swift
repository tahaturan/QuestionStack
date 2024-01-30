//
//  SceneDelegate.swift
//  QuestionStack
//
//  Created by Taha Turan on 17.01.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: HomeViewCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
       
        let navController = UINavigationController()
        coordinator = HomeViewCoordinator(navigationController: navController)
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navController
        coordinator?.start()
        window?.makeKeyAndVisible()
    }
}

