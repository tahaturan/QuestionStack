//
//  LoginViewCoordinator.swift
//  QuestionStack
//
//  Created by Taha Turan on 30.01.2024.
//

import Foundation
import UIKit

protocol LoginViewCoordinatorProtocol {
    func goHomeVC()
    func goRegisterVC()
}

final class LoginViewCoordinator: Coordinator, LoginViewCoordinatorProtocol {

    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func start() {
        let loginVC = LoginViewBuilder.makeLoginViewContoller()
        loginVC.coordinator = self
        navigationController?.pushViewController(loginVC, animated: true)
    }
    
    func goHomeVC() {
        let homeVC = HomeViewControllerBuilder.makeHomeViewController()
        homeVC.coordinator = HomeViewCoordinator(navigationController: navigationController)
        
        navigationController?.setViewControllers([homeVC], animated: true)
    }
    func goRegisterVC() {
        let registerVC = RegisterViewCoordinator(navigationController: navigationController)
        registerVC.start()
    }
}
