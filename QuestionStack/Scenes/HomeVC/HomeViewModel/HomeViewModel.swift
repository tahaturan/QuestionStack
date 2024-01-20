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
        setLoading(true)
            self.service.fetchData(.getQuestions(page: 1)) { (result: Result<QuestionsModel, NetworkError>) in
                self.setLoading(false)
                switch result {
                case .success(let questionModel):
                    self.delegate?.handleOutput(.questions(questionModel.items))
                case .failure(let error):
                    self.delegate?.handleOutput(.error(error))
                }
            }
        
    }
    func setLoading(_ isLoading: Bool) {
        self.delegate?.handleOutput(.setLoading(isLoading))
    }
    
}
