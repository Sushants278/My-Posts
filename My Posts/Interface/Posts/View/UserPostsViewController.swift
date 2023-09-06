//
//  UserPostsViewController.swift
//  My Posts
//
//  Created by Sushant Shinde on 04.09.23.
//

import UIKit

class UserPostsViewController: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel = UserPostsViewModel()
    private let userPostsView = UserPostsView()
    
    // MARK: - view Lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.configureView()
        self.viewModel.fetchUserPosts()
    }
    
    override func loadView() {
        
        view = userPostsView
    }
    
    private func configureView() {
        
        self.view.backgroundColor = .white
        self.title = "My Posts"
        self.viewModel.delegate = self
        
        self.userPostsView.tableView.register(UserPostTableViewCell.self, forCellReuseIdentifier: "UserPostCell")
        self.userPostsView.tableView.dataSource = self
        self.userPostsView.tableView.delegate = self
        self.userPostsView.headerView.delegate = self
    }
}

extension UserPostsViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - UITableViewDataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        viewModel.userPosts?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserPostCell", for: indexPath) as? UserPostTableViewCell, let userPost = viewModel.userPosts?[indexPath.row] else {
            
            fatalError("Unable to dequeue UserPostTableViewCell")
        }
        
        cell.delegate = self
        cell.configure(with: userPost)
        return cell
    }
    
    // MARK: - UITableViewDelegate Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let userPost = viewModel.userPosts?[indexPath.row] else {
            
            return
        }
        
        didTapOnPostCell(userPost: userPost)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        80.0
    }
    
    /// Presents the UserCommentsViewController when a user post cell is tapped.
    /// - Parameter userPost: The user post associated with the tapped cell.
    
    private func didTapOnPostCell(userPost: UserPost) {
        
        let viewModel = UserCommentsViewModel(userPost: userPost)
        let userCommentsVC = UserCommentsViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(userCommentsVC, animated: true)
    }
}

extension UserPostsViewController : UserPostsViewModelDelegate {
    
    /// Reloads a specific table view row with updated user posts data.
    /// - Parameter indexPath: specific reload indexPath

    func presentUpdatedUserPosts(indexPath: IndexPath) {
        
        DispatchQueue.main.async {
            
            self.userPostsView.tableView.reloadRows(at: [indexPath], with: .none)
        }
    }
    
    /// Updates the UI to present user posts or hides the "No Data" view accordingly.

    func presentUserPosts() {
        
        DispatchQueue.main.async {
            
            let isHiddenNoDataView = (self.viewModel.userPosts?.isEmpty ?? false)
            self.userPostsView.noDataView.isHidden = !isHiddenNoDataView
            self.userPostsView.tableView.reloadData()
        }
    }
    
    /// Shows the "No Data" view in case of a failure in loading user posts.

    func presentFailureScreen() {
        
        self.userPostsView.noDataView.isHidden = false
    }
}

extension UserPostsViewController : HeaderViewDelegate {
    
    /// Handles the value change event of the segmented control in the header view.
   /// - Parameter selectedIndex: The index of the selected segment.
    
    func segmentedControlValueChanged(_ selectedIndex: Int) {
        
        let isShowFavortie = selectedIndex != 0
        viewModel.showAllOrFavoriteUserPosts(isShowFavorite: isShowFavortie)
    }
}

extension UserPostsViewController : UserPostTableViewDelegate {

    /// Handles the tap event of the favorite button in a user post cell.
    /// - Parameter userPost: The user post for which the favorite button was tapped.
    
    func didTapFavouriteButton(userPost: UserPost) {
        
        viewModel.favoritePost(userPost: userPost)
    }
}
