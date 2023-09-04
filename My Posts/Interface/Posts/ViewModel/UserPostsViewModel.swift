//
//  UserPostsViewModel.swift
//  My Posts
//
//  Created by Sushant Shinde on 04.09.23.
//

import Foundation

protocol UserPostsViewModelDelegate: AnyObject {
    
    func presentUserPosts()
    func presentFailureScreen()
}

class UserPostsViewModel {
    
    weak var userPostsViewModelDelegate: UserPostsViewModelDelegate?
    var userPosts: UserPosts?
    
    func fetchUserPosts() {
        
        let userID = UserManager.shared.getUserID() ?? ""
        
        NetworkManager.shared.fetchUserPosts(for: userID) { userPosts, error in
            
            if let _ = error {
                
                self.userPostsViewModelDelegate?.presentFailureScreen()
            } else {
                
                self.userPosts = userPosts
                self.userPostsViewModelDelegate?.presentUserPosts()
            }
        }
    }
}
