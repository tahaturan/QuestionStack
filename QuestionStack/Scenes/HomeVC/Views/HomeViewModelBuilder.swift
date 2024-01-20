//
//  HomeViewModelBuilder.swift
//  QuestionStack
//
//  Created by Taha Turan on 20.01.2024.
//

import Foundation

final class HomeViewControllerBuilder {
    private init() {}
    static func makeHomeViewController() -> HomeViewController {
     let homeVC = HomeViewController()
        let viewModel = HomeViewModel(service: NetworkManager())
        homeVC.homeViewModel = viewModel
        return homeVC
    }
}
