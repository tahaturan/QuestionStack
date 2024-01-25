//
//  DetailViewControllerBuilder.swift
//  QuestionStack
//
//  Created by Taha Turan on 23.01.2024.
//

import Foundation

final class DetailViewControllerBuilder {
    
    static func makeDetailViewController(questionItem: QuestionItem) -> DetailViewController {
        let detailVC = DetailViewController()
        let viewModel: DetailViewModel = DetailViewModel(service: NetworkManager(), questionId: questionItem.questionID)
        detailVC.detailViewModel = viewModel
        detailVC.questionItem = questionItem
        detailVC.navigationController?.navigationBar.prefersLargeTitles = false
        detailVC.navigationItem.largeTitleDisplayMode = .never
        return detailVC
    }
}
