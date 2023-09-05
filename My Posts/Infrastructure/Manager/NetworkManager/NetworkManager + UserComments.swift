//
//  NetworkManager + UserComments.swift
//  My Posts
//
//  Created by Sushant Shinde on 05.09.23.
//

import Foundation


typealias UserCommentsCompletionClosure = ((UserComments?, Error?) -> Void)


protocol UserCommentsRequests {
    
    func fetchUserPostComments(for postID: String, handler: @escaping UserCommentsCompletionClosure)
}

extension NetworkManager: UserCommentsRequests {
    
    func fetchUserPostComments(for postID: String, handler: @escaping UserCommentsCompletionClosure) {
        
        var urlComponents = self.urlComponents
        urlComponents.path = "/posts/\(postID)/comments"
        
        guard let url = urlComponents.url else {
            
            handler(nil, NetworkError.invalidUrl)
            return
        }
        
        let request = URLRequest(url: url)
        
        executeRequest(request: request, completion: handler)
    }
}
