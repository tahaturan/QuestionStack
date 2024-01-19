//
//  QuestionService.swift
//  QuestionStack
//
//  Created by Taha Turan on 18.01.2024.
//

import Foundation

protocol QuestionServiceDelegate {
    func getQuestions(page: Int, completion: @escaping (Result<QuestionsModel, NetworkError>) -> Void)
    func getQuestionAnswers(questionID: Int, comletion: @escaping (Result<QuestionsAnswerModel, NetworkError>) -> Void)
}

final class QuestionService: QuestionServiceDelegate {

    static let shared = QuestionService()
    private init() {}
    
    func getQuestions(page: Int, completion: @escaping (Result<QuestionsModel, NetworkError>) -> Void) {
        NetworkManager.shared.fetchData(.getQuestions(page: page), completion: completion)
    }
    
    func getQuestionAnswers(questionID: Int, comletion: @escaping (Result<QuestionsAnswerModel, NetworkError>) -> Void) {
        NetworkManager.shared.fetchData(.getQestionAnswers(questionId: questionID), completion: comletion)
    }
    
}
