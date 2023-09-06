//
//  NetworkManager + UserPosts.swift
//  My Posts
//
//  Created by Sushant Shinde on 04.09.23.
//

import Foundation


typealias UserPostsCompletionClosure = ((UserPosts?, Error?) -> Void)


protocol UserPostsRequests {
    
    func fetchUserPosts(for userID: String, handler: @escaping UserPostsCompletionClosure)
}

extension NetworkManager: UserPostsRequests {
    
    ///Fetches user posts for a given user ID.
    ///- Parameters:
    ///  - userID: The ID of the user for whom posts are fetched.
    /// - handler: A closure to be called upon completion with the fetched user posts or an error.

    func fetchUserPosts(for userID: String, handler: @escaping UserPostsCompletionClosure) {
        
        var urlComponents = self.urlComponents
        urlComponents.path = "/users/\(userID)/posts"
        
        guard let url = urlComponents.url else {
            
            handler(nil, NetworkError.invalidUrl)
            return
        }
        
        let request = URLRequest(url: url)
        
        executeRequest(request: request, completion: handler)
    }
}
