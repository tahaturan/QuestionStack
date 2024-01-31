//
//  LoginViewModelContracts.swift
//  QuestionStack
//
//  Created by Taha Turan on 31.01.2024.
//

import Foundation

protocol LoginViewModelContracts {
    var delegate: LoginViewModelDelegate? { get set }
    func login(email: String?, password: String?)
    func setLoading(_ isLoading: Bool)
}

enum LoginViewModelOutput {
    case loginIsSuccess(Bool)
    case error(FireBaseError)
    case setLoading(Bool)
}

protocol LoginViewModelDelegate: AnyObject {
    func handleOutput(_ output: LoginViewModelOutput)
}
