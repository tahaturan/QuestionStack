//
//  DetailViewControllerBuilder.swift
//  QuestionStack
//
//  Created by Taha Turan on 23.01.2024.
//

import Foundation

final class DetailViewControllerBuilder {
    
    static func makeDetailViewController(questionID: Int, questionItem: QuestionItem) -> DetailViewController {
        let detailVC = DetailViewController()
        let viewModel: DetailViewModel = DetailViewModel(service: NetworkManager(), questionId: questionID)
        detailVC.detailViewModel = viewModel
        detailVC.questionItem = questionItem
        detailVC.navigationController?.navigationBar.prefersLargeTitles = false
        detailVC.navigationItem.largeTitleDisplayMode = .never
        return detailVC
    }
}
