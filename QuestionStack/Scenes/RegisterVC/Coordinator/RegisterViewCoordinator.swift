//
//  RegisterViewCoordinator.swift
//  QuestionStack
//
//  Created by Taha Turan on 31.01.2024.
//

import UIKit

final class RegisterViewCoordinator: Coordinator {
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func start() {
        let registerVC = RegisterViewBuilder.makeRegisterViewController()
        registerVC.coordinator = self
        navigationController?.pushViewController(registerVC, animated: true)
    }
    
    
}
