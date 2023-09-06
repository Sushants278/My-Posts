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
    
    weak var delegate: LoginViewModelDelegate?
    
    /// Attempts to log in with the provided user ID.
    /// - Parameter userID: The user ID entered by the user.
    
    func loginWith(userID: String) {
        
        guard let isUserValid = Int(userID), (1...10).contains(isUserValid) else {
            
            delegate?.presentLoginFailure()
            return
        }
        
        UserManager.shared.saveUserID(userID)
        delegate?.presentLoginSuccessful()
    }
}
