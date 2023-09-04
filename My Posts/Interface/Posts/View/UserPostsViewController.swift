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
        self.view.backgroundColor = .white
        self.title = "User Posts"
        self.viewModel.userPostsViewModelDelegate = self
        
        self.userPostsView.tableView.register(UserPostTableViewCell.self, forCellReuseIdentifier: "UserPostCell")
        self.userPostsView.tableView.dataSource = self
        self.userPostsView.tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.viewModel.fetchUserPosts()
    }
    
    override func loadView() {
        
        view = userPostsView
    }
}

extension UserPostsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        viewModel.userPosts?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserPostCell", for: indexPath) as? UserPostTableViewCell else {
            fatalError("Unable to dequeue UserPostTableViewCell")
        }
        
        cell.configure(with: viewModel.userPosts?[indexPath.row])
        return cell
    }
}

extension UserPostsViewController : UserPostsViewModelDelegate {
    
    func presentUserPosts() {
    
        DispatchQueue.main.async {
            
            self.userPostsView.tableView.reloadData()

        }
    }
    
    func presentFailureScreen() {
        
    }
}
