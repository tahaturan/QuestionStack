//
//  RegisterViewModelContracts.swift
//  QuestionStack
//
//  Created by Taha Turan on 31.01.2024.
//

import Foundation
protocol RegisterViewModelContracts {
    var delegate: RegisterViewModelDelegate? { get set }
    func register(email: String?, password: String?)
    func setLoading(_ isloading: Bool)
}


enum registerViewModelOutput {
    case registerIsSuccess(success: Bool? = nil, error: Error? = nil)
    case setLoading(Bool)
}


protocol RegisterViewModelDelegate: AnyObject {
    func handleOutput(_ output: registerViewModelOutput)
}
