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
    
    func save(userID: String) {
        
        guard let userIDInt = Int(userID), (1...10).contains(userIDInt) else {
            
            delegate?.presentLoginFailure()
            return
        }
        
        UserManager.shared.saveUserID(userID)
        delegate?.presentLoginSuccessful()
    }
}
