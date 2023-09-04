//
//  LoginView.swift
//  My Posts
//
//  Created by Sushant Shinde on 04.09.23.
//

import UIKit

protocol LoginViewDelegate: AnyObject {
    
    func loginButtonTapped(userID: String)
}

class LoginView: UIView {

    weak var delegate: LoginViewDelegate?

    private let userIDTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter UserID"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupObservers()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        setupObservers()
    }

    private func setupUI() {
        
        self.backgroundColor = .white
        
        addSubview(userIDTextField)
        addSubview(loginButton)

        NSLayoutConstraint.activate([
            
            userIDTextField.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            userIDTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            userIDTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            userIDTextField.heightAnchor.constraint(equalToConstant: 40),
            
            loginButton.topAnchor.constraint(equalTo: userIDTextField.bottomAnchor, constant: 16),
            loginButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 120), // Set the desired width
            loginButton.heightAnchor.constraint(equalToConstant: 40)
        ])

        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }

    @objc private func loginButtonTapped() {
        
        guard let userID = userIDTextField.text else { return }
        
        delegate?.loginButtonTapped(userID: userID)
    }
    
    private func setupObservers() {
        
         userIDTextField.addTarget(self, action: #selector(userIDTextFieldDidChange), for: .editingChanged)
     }

     @objc private func userIDTextFieldDidChange() {
      
         loginButton.isEnabled = !( userIDTextField.text ?? "" ).isEmpty
     }
}
