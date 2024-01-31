//
//  RegisterViewModel.swift
//  QuestionStack
//
//  Created by Taha Turan on 31.01.2024.
//

import Foundation

final class RegisterViewModel: RegisterViewModelContracts {
   weak var delegate: RegisterViewModelDelegate?
    
    func register(email: String?, password: String?) {
        delegate?.handleOutput(.loginIsSuccess(success: false, error: .networkError))
    }
    
    func setLoading(_ isloading: Bool) {
        delegate?.handleOutput(.setLoading(isloading))
    }
    
    
}
