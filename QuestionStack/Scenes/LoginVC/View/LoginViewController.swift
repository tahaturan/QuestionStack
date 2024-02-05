//
//  LoginViewController.swift
//  QuestionStack
//
//  Created by Taha Turan on 30.01.2024.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    //MARK: - Properties
    var coordinator: LoginViewCoordinator?
    var loginViewModel: LoginViewModel?
    //MARK: - UICompenents
    private lazy var emailTextfield: CustomTextField = CustomTextField(type: .email)
    private lazy var passwordTextfield: CustomTextField = CustomTextField(type: .password)
    private lazy var loginButton: UIButton = makeButton(title: "Login")
    private lazy var registerButton: UIButton = makeButton(title: "Register")
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
        loginViewModel?.delegate = self
        ReachabilityManager.shared.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ReachabilityManager.shared.startMonitoring()
    }
}
//MARK: - Helper
extension LoginViewController {
    private func setupUI() {
        view.backgroundColor = .white
        title = "Login"
        makeEmailTextfield()
        makePassworkdTextfield()
        makeLoginButton()
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
    private func makeLoginButton() {
        view.addSubview(loginButton)
        loginButton.addTarget(self, action: #selector(loginButtonTapped(_:)), for: .touchUpInside)
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextfield.snp.bottom).offset(40)
            make.left.right.height.equalTo(emailTextfield)
        }
    }
    private func makeRegisterButton() {
        view.addSubview(registerButton)
        registerButton.addTarget(self, action: #selector(registerButtonTapped(_:)), for: .touchUpInside)
        registerButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(10)
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
extension LoginViewController {
    @objc private func loginButtonTapped(_ sender: UIButton) {
        self.loginViewModel?.login(email: emailTextfield.text, password: passwordTextfield.text)
    }
    @objc private func registerButtonTapped(_ sender: UIButton) {
        self.coordinator?.goRegisterVC()
    }
}

//MARK: - LoginViewModelDelegate
extension LoginViewController: LoginViewModelDelegate {
    func handleOutput(_ output: LoginViewModelOutput) {
        switch output {
        case .loginIsSuccess(let success, let error):
            if error != nil {
                self.showAlert(title: "Error", message: error!.localizedDescription)
            }
            if let success = success {
                if success {
                    self.coordinator?.goHomeVC()
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
//MARK: - ReachabilityManagerDelegate
extension LoginViewController: ReachabilityManagerDelegate {
    func isNetworkReachability(isAvaiable: Bool) {
        if !isAvaiable {
            DispatchQueue.main.async {
                self.loginButton.setTitle("Network is not Avaiable", for: .normal)
                self.loginButton.isEnabled = false
                self.loginButton.backgroundColor = .lightGray
            }
        } else {
            DispatchQueue.main.async {
                self.loginButton.setTitle("LogIn", for: .normal)
                self.loginButton.isEnabled = true
                self.loginButton.backgroundColor = .blue.withAlphaComponent(0.5)
            }
        }
    }
    
    
}

//MARK: - Factory Methods
extension LoginViewController {
    private func makeButton(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.backgroundColor = .blue.withAlphaComponent(0.5)
        button.setTitleColor(.white, for: .normal)
        return button
    }
}
