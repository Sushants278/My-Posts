//
//  LoginViewModel.swift
//  My Posts
//
//  Created by Sushant Shinde on 04.09.23.
//

import Foundation

protocol LoginViewModelDelegate: AnyObject {
    
    func presentLoginSuccessful()
    func presentLoginFailure()
}

class LoginViewModel {
    
    weak var loginViewModelDelegate: LoginViewModelDelegate?
    
    func save(userID: String) {
        
        UserManager.shared.saveUserID(userID)
        loginViewModelDelegate?.presentLoginSuccessful()
    }
}
