//
//  RegisterViewController.swift
//  QuestionStack
//
//  Created by Taha Turan on 31.01.2024.
//

import UIKit

class RegisterViewController: UIViewController {
    //MARK: - Properties
    var registerViewModel: RegisterViewModel?
    var coordinator: RegisterViewCoordinator?

    //MARK: - UIComponents
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}
//MARK: - Helper
extension RegisterViewController {
    private func setupUI() {
        view.backgroundColor = .white
    }
}
