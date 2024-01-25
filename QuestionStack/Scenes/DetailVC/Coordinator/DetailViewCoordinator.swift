//
//  DetailViewCoordinator.swift
//  QuestionStack
//
//  Created by Taha Turan on 25.01.2024.
//

import UIKit

protocol DetailViewCoordinatorProtocol {
    var questionItem: QuestionItem { get set }
}

final class DetailViewCoordinator: Coordinator, DetailViewCoordinatorProtocol {
    var navigationController: UINavigationController?
    var questionItem: QuestionItem
    
    init(navigationController: UINavigationController?, questionItem: QuestionItem) {
        self.navigationController = navigationController
        self.questionItem = questionItem
    }
    func start() {
        let detailVC = DetailViewControllerBuilder.makeDetailViewController(questionItem: questionItem)
        detailVC.coordinator = self
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
