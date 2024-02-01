//
//  LoginViewModel.swift
//  QuestionStack
//
//  Created by Taha Turan on 30.01.2024.
//

import Foundation
final class LoginViewModel: LoginViewModelContracts {
    weak var delegate: LoginViewModelDelegate?

    init() {
        ReachabilityManager.shared.startMonitoring()
    }
    deinit {
        ReachabilityManager.shared.stopMonitoring()
    }
    
    func login(email: String?, password: String?) {
        guard let email = email, !email.isEmpty else {
            delegate?.handleOutput(.loginIsSuccess(error: FireBaseError.customError(message: "empty E-mail")))
            return
        }
        guard let password = password, !password.isEmpty else {
            delegate?.handleOutput(.loginIsSuccess(error: FireBaseError.customError(message: "empty Password")))
            return
        }
        if !ReachabilityManager.shared.isNetworkAvaiable {
            delegate?.handleOutput(.loginIsSuccess(error: FireBaseError.networkError))
            return
        }
        self.setLoading(true)
        FirebaseService.shared.signIn(email: email, password: password) { [weak self] result in
            self?.setLoading(false)
            switch result {
            case .success(_):
                self?.delegate?.handleOutput(.loginIsSuccess(success: true))
            case .failure(let error):
                self?.delegate?.handleOutput(.loginIsSuccess(error: error))
            }
        }
    }

    func setLoading(_ isLoading: Bool) {
        delegate?.handleOutput(.setLoading(isLoading))
    }
}
