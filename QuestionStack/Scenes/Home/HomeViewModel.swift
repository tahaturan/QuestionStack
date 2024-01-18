//
//  HomeViewModel.swift
//  QuestionStack
//
//  Created by Taha Turan on 18.01.2024.
//

import Foundation

protocol HomeViewModelInterFace {
    func loadData()
}

final class HomeViewModel: HomeViewModelInterFace {
     func loadData() {
        QuestionService.shared.getQuestionAnswers(questionID: 45916331) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    print(success.items.map({$0.owner.displayName}))
                case .failure(let failure):
                    print(failure.rawValue)
                }
            }
        }
    }
}
