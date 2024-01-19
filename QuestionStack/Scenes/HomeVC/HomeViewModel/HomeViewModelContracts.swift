//
//  HomeViewModelContracts.swift
//  QuestionStack
//
//  Created by Taha Turan on 19.01.2024.
//

import Foundation

protocol HomeViewModelContracts {
    var delegate: HomeViewModelDelegate? { get set }
    func load()
    func setLoading(_ isLoading: Bool)
}

enum HomeViewModelOutput {
    case questions([QuestionItem])
    case error(NetworkError)
    case setLoading(Bool)
}

protocol HomeViewModelDelegate {
    func handleOutput(_ output: HomeViewModelOutput)
}
