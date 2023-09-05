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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.viewModel.fetchUserPosts()
        self.viewModel.fetchAndPrintEachPerson()
    }
    
    override func loadView() {
        
        view = userPostsView
    }
    
    private func configureView() {
        
        self.view.backgroundColor = .white
        self.title = "User Posts"
        self.viewModel.userPostsViewModelDelegate = self
        
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        50.0
    }
}

extension UserPostsViewController : UserPostsViewModelDelegate {
    
    func presentUserPosts() {
    
       self.userPostsView.tableView.reloadData()
    }
    
    func presentFailureScreen() {
        
    }
}

extension UserPostsViewController : HeaderViewDelegate {
    
    func segmentedControlValueChanged(_ selectedIndex: Int) {
        
    }
}

extension UserPostsViewController : UserPostTableViewDelegate {

    func didTapFavouriteButton(userPost: UserPost) {
        
        viewModel.saveToFavorites(userPost: userPost)
    }
}
