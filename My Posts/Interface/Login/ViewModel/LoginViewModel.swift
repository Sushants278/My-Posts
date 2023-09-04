//
//  LoginViewModel.swift
//  My Posts
//
//  Created by Sushant Shinde on 04.09.23.
//

import Foundation

class LoginViewModel {
    
    private var userModel: User?

    var userID: String {
        return userModel?.userID ?? ""
    }

    func setUser(userID: String) {
        
        userModel = User(userID: userID)
    }
}
