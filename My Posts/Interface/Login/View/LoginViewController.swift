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
        viewModel.loginViewModelDelegate = self
    }
    
    override func loadView() {
        
        view = loginView
    }
}

extension LoginViewController: LoginViewDelegate {
    
    func didTapLoginButton(userID: String) {
        
        viewModel.save(userID: userID)
    }
}

extension LoginViewController: LoginViewModelDelegate {
    
    func presentLoginSuccessful() {
        
        let userPostsViewController = UserPostsViewController()
        
        let navigationController = UINavigationController(rootViewController: userPostsViewController)
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            
            appDelegate.window?.rootViewController = navigationController
        }
    }
    
    func presentLoginFailure() {
        
        /* TO handle failure scenario*/
        
    }
}
