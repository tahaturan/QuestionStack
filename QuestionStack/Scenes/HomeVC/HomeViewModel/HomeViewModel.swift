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
    private(set) var questionList: Observable<[QuestionItem]> = Observable()
    private(set) var listCount: Int = 0
     func loadData() {
         QuestionService.shared.getQuestions(page: 1) { [weak self] result in
                 switch result {
                 case .success(let questionsList):
                     self?.questionList.value = questionsList.items
                     self?.listCount = questionsList.items.count
                 case .failure(let failure):
                     print(failure.rawValue)
                 }
         }
    }
}
