//
//  HomeViewCoordinator.swift
//  QuestionStack
//
//  Created by Taha Turan on 25.01.2024.
//

import UIKit

protocol HomeViewCoordinatorProtocol: AnyObject {
    func goToDetail(with questionItem: QuestionItem)
    func goLogin()
}

final class HomeViewCoordinator: Coordinator, HomeViewCoordinatorProtocol {

    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func start() {
        let homeVC = HomeViewControllerBuilder.makeHomeViewController()
        homeVC.coordinator = self
        navigationController?.pushViewController(homeVC, animated: true)
    }
    
    func goToDetail(with questionItem: QuestionItem) {
        let detailCoordinator = DetailViewCoordinator(navigationController: navigationController, questionItem: questionItem)
        detailCoordinator.start()
    }
    func goLogin() {
        let loginVC = LoginViewBuilder.makeLoginViewContoller()
        loginVC.coordinator = LoginViewCoordinator(navigationController: navigationController)
        
        navigationController?.setViewControllers([loginVC], animated: true)
    }
}
