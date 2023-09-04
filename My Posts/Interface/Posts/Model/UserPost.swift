//
//  UserPost.swift
//  My Posts
//
//  Created by Sushant Shinde on 04.09.23.
//

import Foundation

typealias UserPosts = [UserPost]

// MARK: - UserPost
struct UserPost: Codable {
    let userID, id: Int
    let title, body: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}


