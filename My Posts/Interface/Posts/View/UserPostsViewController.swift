//
//  UserPostsViewController.swift
//  My Posts
//
//  Created by Sushant Shinde on 04.09.23.
//

import UIKit

class UserPostsViewController: UIViewController {
    
    private let viewModel = UserPostsViewModel()
    private let userPostsView = UserPostsView()
    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let userPost = viewModel.userPosts?[indexPath.row] else {
            
            return
        }
        
        didTapOnPostCell(userPost: userPost)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        80.0
    }
    
    func didTapOnPostCell(userPost: UserPost) {
        
        let viewModel = UserCommentsViewModel(userPost: userPost)
        let userCommentsVC = UserCommentsViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(userCommentsVC, animated: true)
    }
}

extension UserPostsViewController : UserPostsViewModelDelegate {
    
    
    func presentUpdatedUserPosts(indexPath: IndexPath) {
        
        DispatchQueue.main.async {
            
            self.userPostsView.tableView.reloadRows(at: [indexPath], with: .none)
        }
    }
    
    
    func presentUserPosts() {
        
        DispatchQueue.main.async {
            
            let isHiddenNoDataView = (self.viewModel.userPosts?.isEmpty ?? false)
            self.userPostsView.noDataView.isHidden = !isHiddenNoDataView
            self.userPostsView.tableView.reloadData()
        }
    }
    
    func presentFailureScreen() {
        
        self.userPostsView.noDataView.isHidden = false
    }
}

extension UserPostsViewController : HeaderViewDelegate {
    
    func segmentedControlValueChanged(_ selectedIndex: Int) {
        
        let isShowFavortie = selectedIndex != 0
        viewModel.showAllOrFavoriteUserPosts(isShowFavorite: isShowFavortie)
    }
}

extension UserPostsViewController : UserPostTableViewDelegate {

    func didTapFavouriteButton(userPost: UserPost) {
        
        viewModel.favoritePost(userPost: userPost)
    }
}
