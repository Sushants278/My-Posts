//
//  LoginView.swift
//  My Posts
//
//  Created by Sushant Shinde on 04.09.23.
//

import UIKit

protocol LoginViewDelegate: AnyObject {
    
    func didTapLoginButton(userID: String)
}

class LoginView: UIView {

    weak var delegate: LoginViewDelegate?

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to My Posts App"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let userIDTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter UserID"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.textColor = .black
        textField.layer.borderColor = UIColor.black.cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.tintColor = .white
        button.layer.cornerRadius = 20
        button.isEnabled = false
        button.backgroundColor = UIColor(red: 0.22, green: 0.49, blue: 0.98, alpha: 1.0) 
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

        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 250),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])

        addSubview(userIDTextField)
        NSLayoutConstraint.activate([
            userIDTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            userIDTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            userIDTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            userIDTextField.heightAnchor.constraint(equalToConstant: 50)
        ])

        addSubview(loginButton)
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: userIDTextField.bottomAnchor, constant: 30),
            loginButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 120),
            loginButton.heightAnchor.constraint(equalToConstant: 40)
        ])

        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }

    @objc private func loginButtonTapped() {
        
        if let userID = userIDTextField.text {
            
            delegate?.didTapLoginButton(userID: userID)
        }
    }

    private func setupObservers() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidChange), name: UITextField.textDidChangeNotification, object: userIDTextField)
    }

    @objc private func textFieldDidChange() {
        loginButton.isEnabled = !(userIDTextField.text?.isEmpty ?? true)
    }
}
