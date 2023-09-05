//
//  UserCommentsViewModel.swift
//  My Posts
//
//  Created by Sushant Shinde on 05.09.23.
//

import Foundation

class UserCommentsViewModel {
    
    private let userPost: UserPost

    init(userPost: UserPost) {
        
        self.userPost = userPost
    }
    
    
    func fetchCommentsForPost() {
        
        NetworkManager.shared.fetchUserPostComments(for: String(self.userPost.id)) { [weak self] postComments, error in
            
            guard let self = self else { return }
            
            if let _ = error {
                
              //  self.userPostsViewModelDelegate?.presentFailureScreen()
            } else {
                
               
            }
        }
    }
}

