//
//  CustomTextField.swift
//  QuestionStack
//
//  Created by Taha Turan on 30.01.2024.
//

import UIKit

enum TextFieldType {
    case email
    case name
    case password
}

class CustomTextField: UITextField {
    init(type: TextFieldType) {
        super.init(frame: .zero)
        commonInit()
        setupTextField(type)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 3
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowColor = UIColor.black.cgColor
        leftViewMode = .always
    }

    private func setupTextField(_ type: TextFieldType) {
        let iconName: String
        switch type {
        case .email:
            placeholder = "E-mail"
            iconName = "envelope"
            autocapitalizationType = .none
            keyboardType = .emailAddress
        case .name:
            placeholder = "Name"
            iconName = "person"
        case .password:
            placeholder = "password"
            iconName = "lock"
            isSecureTextEntry = true
        }

        leftView = createIconView(iconName: iconName)
    }

    private func createIconView(iconName: String) -> UIView {
        let iconView = UIImageView(image: UIImage(systemName: iconName))
        iconView.contentMode = .scaleAspectFit
        iconView.tintColor = .lightGray
        let iconContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 30))
        iconView.frame = CGRect(x: 10, y: 0, width: 30, height: 30)
        iconContainerView.addSubview(iconView)

        return iconContainerView
    }
}
