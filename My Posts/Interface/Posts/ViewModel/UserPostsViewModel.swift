//
//  UserPostsViewModel.swift
//  My Posts
//
//  Created by Sushant Shinde on 04.09.23.
//

import Foundation
import CoreData

protocol UserPostsViewModelDelegate: AnyObject {
    
    func presentUserPosts()
    func presentFailureScreen()
}

class UserPostsViewModel {
    
    weak var userPostsViewModelDelegate: UserPostsViewModelDelegate?
    var userPosts: UserPosts?
    
    func fetchUserPosts() {
        
        let userID = UserManager.shared.getUserID() ?? ""
        
        NetworkManager.shared.fetchUserPosts(for: userID) {  [weak self] userPosts, error in
            
            guard let self = self else {
                
                return
            }
            
            if let _ = error {
                
                self.userPostsViewModelDelegate?.presentFailureScreen()
            } else {
                
                self.userPosts = userPosts
                self.parseUserPosts()
            }
        }
    }
    
    func parseUserPosts() {
        if let userPosts = self.userPosts {
            let parsedUserPosts = userPosts.map { item in
                return UserPost(
                    userID: item.userID,
                    id: item.id,
                    title: item.title,
                    body: item.body,
                    isFavorite: isPostFavorite(userId: item.userID, postId: item.id)
                )
            }
            self.userPosts = parsedUserPosts
            self.userPostsViewModelDelegate?.presentUserPosts()
        }
    }

    func favoritePost(userPost: UserPost) {
        
        if !(userPost.isFavorite ?? false) {
            
            saveToFavorites(userPost: userPost)
            
            fetchAndSetFavoritedPosts()
            
        } else {
            
            removeFavorite(userId: userPost.userID, postId: userPost.id)
            
            if let index = userPosts?.firstIndex(where: { $0.id == userPost.id }) {
                
                userPosts?[index].isFavorite = false
            }
        }
        
        self.userPostsViewModelDelegate?.presentUserPosts()
    }


    func saveToFavorites(userPost: UserPost) {
    
        let context = CoreDataStackManager.shared.managedObjectContext
        
        if let userPostEntity = NSEntityDescription.entity(forEntityName: "FavoritePost", in: context),
           let userPostOfflineObject = NSManagedObject(entity: userPostEntity, insertInto: context) as? FavoritePost {
            
            userPostOfflineObject.title = userPost.title
            userPostOfflineObject.body = userPost.body
            userPostOfflineObject.userId = String(userPost.userID)
            userPostOfflineObject.id = String(userPost.id)
            
            CoreDataStackManager.shared.saveContext()
        }
    }
    
    func removeFavorite(userId: Int, postId: Int) {
        let context = CoreDataStackManager.shared.managedObjectContext
        
        let fetchRequest: NSFetchRequest<FavoritePost> = FavoritePost.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "userId == %d AND id == %d", userId, postId)
        
        do {
            let favoritePosts = try context.fetch(fetchRequest)
            for favoritePost in favoritePosts {
                context.delete(favoritePost)
            }
            CoreDataStackManager.shared.saveContext()
        } catch {
            print("Error removing favorite post: \(error)")
        }
    }

    
    func isPostFavorite(userId: Int, postId: Int) -> Bool {
        
        let context = CoreDataStackManager.shared.managedObjectContext

        let fetchRequest: NSFetchRequest<FavoritePost> = FavoritePost.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "userId == %d AND id == %d", userId, postId)
        
        do {
            let favoritePosts = try context.fetch(fetchRequest)
            return !favoritePosts.isEmpty
        } catch {
            print("Error fetching favorite posts: \(error)")
            return false
        }
    }
    
    func getAllFavoritedPosts() -> [UserPost] {
        let context = CoreDataStackManager.shared.managedObjectContext
        
        let fetchRequest: NSFetchRequest<FavoritePost> = FavoritePost.fetchRequest()
        
        do {
            let favoritePosts = try context.fetch(fetchRequest)
            
            return favoritePosts.compactMap { favoritePost in
                return UserPost(
                    userID: Int(favoritePost.userId ?? "") ?? 0,
                    id: Int(favoritePost.id ?? "") ?? 0,
                    title: favoritePost.title ?? "",
                    body: favoritePost.body ?? "",
                    isFavorite: true
                )
            }
        } catch {
            print("Error fetching favorite posts: \(error)")
            return []
        }
    }
    
    func fetchAndSetFavoritedPosts() {
        
        let favoritedPosts = getAllFavoritedPosts()
         for favoritedPost in favoritedPosts {
            if let index = self.userPosts?.firstIndex(where: { $0.id == favoritedPost.id }) {
                self.userPosts?[index].isFavorite = true
            }
        }
    }
}
