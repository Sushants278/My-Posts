//
//  LoginViewController.swift
//  My Posts
//
//  Created by Sushant Shinde on 04.09.23.
//

import UIKit

class LoginViewController: UIViewController {

    private let viewModel = LoginViewModel()
    private let loginView = LoginView()

    override func viewDidLoad() {
        super.viewDidLoad()

        loginView.delegate = self
    }
    
    override func loadView() {
        
        view = loginView
    }
}

extension LoginViewController: LoginViewDelegate {
    
    func loginButtonTapped(userID: String) {
        
        viewModel.setUser(userID: userID)
    }
}
