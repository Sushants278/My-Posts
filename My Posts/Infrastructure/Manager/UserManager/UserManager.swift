//
//  UserManager.swift
//  My Posts
//
//  Created by Sushant Shinde on 04.09.23.
//

import Foundation

class UserManager {
    
    static let shared = UserManager()
    private init() {}

    private let userDefaults = UserDefaults.standard
    private let userIDKey = "userID"

    func saveUserID(_ userID: String) {
        
        userDefaults.set(userID, forKey: userIDKey)
    }

    func getUserID() -> String? {
        
        return userDefaults.string(forKey: userIDKey)
    }

    func clearUserID() {
        
        userDefaults.removeObject(forKey: userIDKey)
    }
}
