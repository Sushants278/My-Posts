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
        
        NetworkManager.shared.fetchUserPosts(for: userID) { userPosts, error in
            
            if let _ = error {
                
                self.userPostsViewModelDelegate?.presentFailureScreen()
            } else {
                
                self.userPosts = userPosts
                self.userPostsViewModelDelegate?.presentUserPosts()
            }
        }
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
    
    func fetchAndPrintEachPerson() {
        
        let context = CoreDataStackManager.shared.managedObjectContext
        
        let fetchRequest = NSFetchRequest<FavoritePost>(entityName: "FavoritePost")
        do {
            let fetchedResults = try context.fetch(fetchRequest)
            for item in fetchedResults {
                print(item.value(forKey: "title"))
            }
        } catch let error as NSError {
            // something went wrong, print the error.
            print(error.description)
        }
    }
}
