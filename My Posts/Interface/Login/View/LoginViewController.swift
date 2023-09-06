//
//  LoginViewController.swift
//  My Posts
//
//  Created by Sushant Shinde on 04.09.23.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - properties
    
    private let viewModel = LoginViewModel()
    private let loginView = LoginView()
    
    // MARK: - view Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginView.delegate = self
        viewModel.delegate = self
    }
    
    override func loadView() {
        
        view = loginView
    }
}

extension LoginViewController: LoginViewDelegate {
    
    /// This method is called when the login button is tapped in the LoginView.
    /// - Parameter userID: The user ID entered by the user.
    
    func didTapLoginButton(userID: String) {
        
        viewModel.loginWith(userID: userID)
    }
}

extension LoginViewController: LoginViewModelDelegate {
    
    /// This method is called when the login is successful. It presents the UserPostsViewController.

    func presentLoginSuccessful() {
        
        let userPostsViewController = UserPostsViewController()
        
        let navigationController = UINavigationController(rootViewController: userPostsViewController)
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            
            appDelegate.window?.rootViewController = navigationController
        }
    }
    
    /// This method is called when the login fails. It presents an alert to inform the user.

    func presentLoginFailure() {
        
        let alertController = UIAlertController(title: "Login Failed", message: "Enter valid userID", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
          alertController.addAction(okAction)
        
          self.present(alertController, animated: true, completion: nil)
    }
}

