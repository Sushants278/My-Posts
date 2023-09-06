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
    func presentUpdatedUserPosts(indexPath: IndexPath)
}

class UserPostsViewModel {
    
    weak var delegate: UserPostsViewModelDelegate?
    private var mainUserPosts: UserPosts?
    var isShowAllUserPosts = true
    var networkService: UserPostsRequests = NetworkManager.shared
    
    var userPosts: UserPosts? {
        didSet {
            
            delegate?.presentUserPosts()
        }
    }
    
    func fetchUserPosts() {
        let userID = UserManager.shared.getUserID() ?? ""
        
        networkService.fetchUserPosts(for: userID) { [weak self] userPosts, error in
            guard let self = self else { return }
            
            if let _ = error {
                
                self.delegate?.presentFailureScreen()
            } else {
                
                self.mainUserPosts = userPosts
                self.prepareUserPosts()
            }
        }
    }
    
    func prepareUserPosts() {
        
        if let userPosts = self.mainUserPosts {
            
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
            self.isShowAllUserPosts = true
        }
    }
    
    func favoritePost(userPost: UserPost) {
        
        if isShowAllUserPosts {
            
            toggleFavorite(userPost: userPost)
        } else {
            
            removeFavorite(userPost: userPost)
            showAllOrFavoriteUserPosts(isShowFavorite: true)
        }
    }
    
    func showAllOrFavoriteUserPosts(isShowFavorite: Bool) {
        
        if !isShowFavorite {
            
            prepareUserPosts()
        } else {
            
            self.isShowAllUserPosts = false
            self.userPosts = getAllFavoritedPosts()
        }
    }
    
    private func toggleFavorite(userPost: UserPost) {
        
        let isFavorite = userPost.isFavorite ?? false
        
        if isFavorite {
            
            removeFavorite(userPost: userPost)
            
        } else {
            
            saveToFavorites(userPost: userPost)
        }
        
        fetchAndUpdateFavoritePosts(isFavorite: !isFavorite, userPost: userPost)
        
        if let indexPath = indexPathForUserPost(userPost) {
            
            delegate?.presentUpdatedUserPosts(indexPath: indexPath)
        }
    }
    
    private func saveToFavorites(userPost: UserPost) {
        
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
    
    private func removeFavorite(userPost: UserPost) {
        
        let context = CoreDataStackManager.shared.managedObjectContext
        let fetchRequest: NSFetchRequest<FavoritePost> = FavoritePost.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "userId == %d AND id == %d", userPost.userID, userPost.id)
        
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
    
    private func isPostFavorite(userId: Int, postId: Int) -> Bool {
        
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
    
    private func getAllFavoritedPosts() -> UserPosts {
        let context = CoreDataStackManager.shared.managedObjectContext
        let userID = Int(UserManager.shared.getUserID() ?? "") ?? -1
        let fetchRequest: NSFetchRequest<FavoritePost> = FavoritePost.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "userId == %d", userID )
        
        do {
            let favoritePosts = try context.fetch(fetchRequest)
            return favoritePosts.map { favoritePost in
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
    
    private func fetchAndUpdateFavoritePosts(isFavorite : Bool, userPost: UserPost) {
        
        guard let userPosts = userPosts else { return }
        if let index = userPosts.firstIndex(where: { $0.id == userPost.id }) {
            self.userPosts?[index].isFavorite = isFavorite
        }
    }
    
    private func indexPathForUserPost(_ userPost: UserPost) -> IndexPath? {
        
        guard let userPosts = userPosts else { return nil }
        if let rowIndex = userPosts.firstIndex(where: { $0.id == userPost.id }) {
            return IndexPath(row: rowIndex, section: 0)
        }
        return nil
    }
}
