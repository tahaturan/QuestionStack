//
//  LoginViewModel.swift
//  QuestionStack
//
//  Created by Taha Turan on 30.01.2024.
//

import Foundation
final class LoginViewModel: LoginViewModelContracts {
    weak var delegate: LoginViewModelDelegate?

    func login(email: String?, password: String?) {
        guard let email = email, !email.isEmpty else {
            delegate?.handleOutput(.error(.customError(message: "Empty E-mail")))

            return
        }
    }

    func setLoading(_ isLoading: Bool) {
        delegate?.handleOutput(.setLoading(isLoading))
    }
}
