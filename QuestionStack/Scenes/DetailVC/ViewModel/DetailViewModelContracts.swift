//
//  DetailViewModelContracts.swift
//  QuestionStack
//
//  Created by Taha Turan on 23.01.2024.
//

import Foundation

protocol DetailViewModelContracts {
    var delagate: DetailViewModelDelegate? {get set}
    func getAnswers()
    func setLoading(_ isLoading: Bool)
}

enum DetailViewModelOutput {
    case answers([AnswerItem])
    case error(NetworkError)
    case setLoading(Bool)
}

protocol DetailViewModelDelegate {
    func handleOutput(_ output: DetailViewModelOutput)
}
