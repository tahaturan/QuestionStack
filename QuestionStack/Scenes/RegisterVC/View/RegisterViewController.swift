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

    //MARK: - UICompenents
    private lazy var emailTextfield: CustomTextField = CustomTextField(type: .email)
    private lazy var passwordTextfield: CustomTextField = CustomTextField(type: .password)
    private lazy var signUpButton: UIButton = makeButton(title: "SignUp")
    private var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.color = .black
        return indicator
    }()
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        registerViewModel?.delegate = self
        ReachabilityManager.shared.delegate = self
    }
}
//MARK: - Helper
extension RegisterViewController {
    private func setupUI() {
        view.backgroundColor = .white
        title = "Register"
        makeEmailTextfield()
        makePassworkdTextfield()
        makeRegisterButton()
        makeActivityIndicator()
    }
    
    private func makeEmailTextfield() {
        view.addSubview(emailTextfield)
        
        emailTextfield.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(50)
        }
    }
    private func makePassworkdTextfield() {
        view.addSubview(passwordTextfield)
        
        passwordTextfield.snp.makeConstraints { make in
            make.top.equalTo(emailTextfield.snp.bottom).offset(20)
            make.left.right.height.equalTo(emailTextfield)
        }
    }
    private func makeRegisterButton() {
        view.addSubview(signUpButton)
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped(_:)), for: .touchUpInside)
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextfield.snp.bottom).offset(40)
            make.left.right.height.equalTo(emailTextfield)
        }
    }
    private func makeActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

//MARK: - Selector
extension RegisterViewController {

    @objc private func signUpButtonTapped(_ sender: UIButton) {
        self.registerViewModel?.register(email: emailTextfield.text, password: passwordTextfield.text)
    }
}

//MARK: - LoginViewModelDelegate
extension RegisterViewController: RegisterViewModelDelegate {
    func handleOutput(_ output: registerViewModelOutput) {
        switch output {
        case .registerIsSuccess(let success, let error):
            if error != nil {
                self.showAlert(title: "Error!!!", message: error!.localizedDescription)
            }
            if let success = success {
                if success {
                    self.showAlert(title: "Success", message: "Register is Success") {
                        self.coordinator?.goBackLoginView()
                    }
                }
            }
        case .setLoading(let isLoading):
            DispatchQueue.main.async {
                if isLoading {
                    self.activityIndicator.startAnimating()
                }else {
                    
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }
}
extension RegisterViewController: ReachabilityManagerDelegate {
    func isNetworkReachability(isAvaiable: Bool) {
        if !isAvaiable {
            DispatchQueue.main.async {
                self.signUpButton.setTitle("Network is not avaiable", for: .normal)
                self.signUpButton.isEnabled = false
                self.signUpButton.backgroundColor = .lightGray
            }
        } else {
            self.signUpButton.setTitle("SignUp", for: .normal)
            self.signUpButton.isEnabled = true
            self.signUpButton.backgroundColor = .blue.withAlphaComponent(0.5)        }
        }
    }

    //MARK: - Factory Methods
    extension RegisterViewController {
        private func makeButton(title: String) -> UIButton {
            let button = UIButton()
            button.setTitle(title, for: .normal)
            button.backgroundColor = .blue.withAlphaComponent(0.5)
            button.setTitleColor(.white, for: .normal)
            return button
        }
    }
    

