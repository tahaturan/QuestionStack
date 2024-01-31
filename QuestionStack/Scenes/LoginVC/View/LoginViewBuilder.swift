//
//  LoginViewBuilder.swift
//  QuestionStack
//
//  Created by Taha Turan on 30.01.2024.
//

import Foundation
final class LoginViewBuilder {
    private init() {}
    
    static func makeLoginViewContoller() -> LoginViewController {
        let loginVC = LoginViewController()
        loginVC.loginViewModel = LoginViewModel()
        return loginVC
    }
}
