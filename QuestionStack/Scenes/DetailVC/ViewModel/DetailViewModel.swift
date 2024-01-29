//
//  DetailViewModel.swift
//  QuestionStack
//
//  Created by Taha Turan on 23.01.2024.
//

import Foundation

final class DetailViewModel: DetailViewModelContracts {
   weak var delagate: DetailViewModelDelegate?
    var service: NetworkManagerProtocol
    var questionId: Int
    init(service: NetworkManagerProtocol, questionId: Int) {
        self.service = service
        self.questionId = questionId
        ReachabilityManager.shared.startMonitoring()
    }
    deinit {
        ReachabilityManager.shared.stopMonitoring()
    }
    
    func loadData() {
        if ReachabilityManager.shared.isNetworkAvaiable {
            getAnswers()
        }
    }
    
    func getAnswers() {
        setLoading(true)
        self.service.fetchData(.getQestionAnswers(questionId: questionId)) { [weak self] (result: Result<QuestionsAnswerModel, NetworkError>) in
            self?.setLoading(false)
            switch result {
            case .success(let questionAnswerModel):
                self?.delagate?.handleOutput(.answers(questionAnswerModel.items))
                
            case .failure(let error):
                self?.delagate?.handleOutput(.error(error))
            }
        }
    }
    
    func setLoading(_ isLoading: Bool) {
        self.delagate?.handleOutput(.setLoading(isLoading))
    }
    
    
}
