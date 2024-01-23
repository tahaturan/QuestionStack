//
//  SceneDelegate.swift
//  QuestionStack
//
//  Created by Taha Turan on 17.01.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        Connectivity.shared.startMonitoring()

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UINavigationController(rootViewController: HomeViewControllerBuilder.makeHomeViewController())
        self.window = window
        window.makeKeyAndVisible()
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        Connectivity.shared.stopMonitoring()
    }
}

