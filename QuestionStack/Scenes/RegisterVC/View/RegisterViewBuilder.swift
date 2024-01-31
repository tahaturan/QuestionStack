//
//  RegisterViewBuilder.swift
//  QuestionStack
//
//  Created by Taha Turan on 31.01.2024.
//

import Foundation

final class RegisterViewBuilder {
    private init() {}
    
    static func makeRegisterViewController() -> RegisterViewController {
        let registerVC = RegisterViewController()
        registerVC.registerViewModel = RegisterViewModel()
        return registerVC
    }
}
