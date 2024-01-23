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
    
    //Realm Service
    private var realmService: RealmService = RealmService()
    
    init(service: NetworkManagerProtocol) {
        self.service = service
    }
    
    func loadData() {
        if Connectivity.shared.isConnected {
            getQuestions()
        } else {
            getQuestionsRealm()
        }
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
                    self?.saveQuestionsToRealm(items: questionModel.items)
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
    func getQuestionsRealm() {
        delegate?.handleOutput(.questionRealm(realmService.loadQuestions()))
    }
    //Save to Realm
    private func saveQuestionsToRealm(items: [QuestionItem]) {
        let group = DispatchGroup()
        
        var realmQuestions: [RealmQuestionItem] = []
        
        for item in items {
            group.enter()
            item.toRealmQuestionItem { realmQuestion in
                if let realmQuestion = realmQuestion {
                    realmQuestions.append(realmQuestion)
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.realmService.saveQuestion(questionList: realmQuestions)
        }
    }
    
}
