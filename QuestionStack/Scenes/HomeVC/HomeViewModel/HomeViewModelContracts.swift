//
//  HomeViewModelContracts.swift
//  QuestionStack
//
//  Created by Taha Turan on 19.01.2024.
//

import Foundation

protocol HomeViewModelContracts {
    var delegate: HomeViewModelDelegate? { get set }
    func getQuestions()
    func getQuestionsRealm()
    func getSearchQuestion(query: String?)
    func setLoading(_ isLoading: Bool)
}

enum HomeViewModelOutput {
    case questions([QuestionItem])
    case error(NetworkError)
    case searchQuestions([QuestionItem])
    case questionRealm([RealmQuestionItem])
    case setLoading(Bool)
}

protocol HomeViewModelDelegate: AnyObject {
    func handleOutput(_ output: HomeViewModelOutput)
}
