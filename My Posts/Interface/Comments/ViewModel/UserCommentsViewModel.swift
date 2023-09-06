//
//  UserCommentsViewModel.swift
//  My Posts
//
//  Created by Sushant Shinde on 05.09.23.
//

import Foundation

protocol UserPostCommentsViewModelDelegate: AnyObject {
    func presentUserPostComments()
    func presentFailureScreen()
}

class UserCommentsViewModel {
    
    // MARK: - Properties
    
    let userPost: UserPost
    var postComments: UserComments?
    weak var delegate: UserPostCommentsViewModelDelegate?
    var networkService: UserCommentsRequests = NetworkManager.shared
    
    init(userPost: UserPost) {
        
        self.userPost = userPost
    }
    

    /// Fetches user comments for a specific post and update the results.
    
    func fetchCommentsForPost() {

        networkService.fetchUserPostComments(for: String(self.userPost.id)) { [weak self] postComments, error in
            
            guard let self = self else { return }
            
            if let _ = error {
                
                self.delegate?.presentFailureScreen()
            } else {
                
                self.postComments = postComments
                self.delegate?.presentUserPostComments()
            }
        }
    }
}

