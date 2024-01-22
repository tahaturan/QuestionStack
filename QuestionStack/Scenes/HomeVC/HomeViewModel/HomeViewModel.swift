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
    private var page = 1
    var isPaginating = false
    
    init(service: NetworkManagerProtocol) {
        self.service = service
    }
    
    func getQuestions() {
        guard !isPaginating else {return}
        isPaginating = true
        setLoading(true)
            self.service.fetchData(.getQuestions(page: 1)) {[weak self] (result: Result<QuestionsModel, NetworkError>) in
                self?.setLoading(false)
                self?.isPaginating = false
                switch result {
                case .success(let questionModel):
                    self?.page += 1
                    self?.delegate?.handleOutput(.questions(questionModel.items))
                case .failure(let error):
                    self?.delegate?.handleOutput(.error(error))
                }
            }
    }
    func getSearchQuestion(query: String?) {
        guard let query = query, !query.isEmpty else { return }
        setLoading(true)
            self.service.fetchData(.searchQuestions(searchText: query)) {[weak self] (result: Result<QuestionsModel, NetworkError>) in
                self?.setLoading(false)
                switch result {
                case .success(let questionModel):
                    self?.delegate?.handleOutput(.searchQuestions(questionModel.items))
                case .failure(let error):
                    self?.delegate?.handleOutput(.error(error))
                }
            }
    }
    
    func setLoading(_ isLoading: Bool) {
        self.delegate?.handleOutput(.setLoading(isLoading))
    }
    
}
