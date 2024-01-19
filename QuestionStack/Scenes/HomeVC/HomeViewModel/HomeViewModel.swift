//
//  HomeViewModel.swift
//  QuestionStack
//
//  Created by Taha Turan on 18.01.2024.
//

import Foundation



final class HomeViewModel: HomeViewModelContracts {
    var delegate: HomeViewModelDelegate?
    var service: NetworkManagerProtocol
    
    init(service: NetworkManagerProtocol) {
        self.service = service
    }
    
    func load() {
        service.fetchData(.getQuestions(page: 1)) { (result: Result<QuestionsModel, NetworkError>) in
            switch result {
            case .success(let questionModel):
                self.delegate?.handleOutput(.questions(questionModel.items))
            case .failure(_):
                self.delegate?.handleOutput(.error(.invalidData))
            }
        }
    }
    
    
}
