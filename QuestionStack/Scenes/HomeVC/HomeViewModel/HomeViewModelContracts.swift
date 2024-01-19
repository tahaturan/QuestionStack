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
}

enum HomeViewModelOutput {
    case questions([QuestionItem])
    case error(NetworkError)
}

protocol HomeViewModelDelegate {
    func handleOutput(_ output: HomeViewModelOutput)
}
