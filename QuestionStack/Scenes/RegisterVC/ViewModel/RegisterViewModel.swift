//
//  RegisterViewModel.swift
//  QuestionStack
//
//  Created by Taha Turan on 31.01.2024.
//

import Foundation

final class RegisterViewModel: RegisterViewModelContracts {
   weak var delegate: RegisterViewModelDelegate?
    
    init() {
        //ReachabilityManager.shared.startMonitoring()
    }
    deinit {
        ReachabilityManager.shared.stopMonitoring()
    }
    
    func register(email: String?, password: String?) {

        guard let email = email, !email.isEmpty else {
            delegate?.handleOutput(.registerIsSuccess(error: FireBaseError.customError(message: "E-mail is not empty")))
            return
        }
        guard let password = password, !password.isEmpty else {
            delegate?.handleOutput(.registerIsSuccess( error: FireBaseError.customError(message: "Password is not empty")))
            return
        }
        if !ReachabilityManager.shared.isNetworkAvaiable {
            delegate?.handleOutput(.registerIsSuccess(error: FireBaseError.networkError))
            return
        }
        setLoading(true)
        FirebaseService.shared.signUp(email: email, password: password) { [weak self] result in
            self?.setLoading(false)
            switch result {
            case .success(_):
                self?.delegate?.handleOutput(.registerIsSuccess(success: true))
            case .failure(let error):
                self?.delegate?.handleOutput(.registerIsSuccess(error: error))
            }
        }
    }
    
    func setLoading(_ isloading: Bool) {
        delegate?.handleOutput(.setLoading(isloading))
    }
    
    
}
