//
//  UserComment.swift
//  My Posts
//
//  Created by Sushant Shinde on 05.09.23.
//

import Foundation

// MARK: - UserComment
struct UserComment: Codable {
    let postID, id: Int
    let name, email, body: String

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case id, name, email, body
    }
}

typealias UserComments = [UserComment]
