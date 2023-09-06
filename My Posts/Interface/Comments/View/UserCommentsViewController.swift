//
//  UserCommentsViewController.swift
//  My Posts
//
//  Created by Sushant Shinde on 05.09.23.
//

import UIKit

class UserCommentsViewController: UIViewController {
    
    // MARK: - Properties

    var viewModel: UserCommentsViewModel?
    private let userCommentsView = UserCommentsView()
    
    init(viewModel: UserCommentsViewModel? = nil) {
        
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    // MARK: - view Lifecycle
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        
        view = userCommentsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.title = "Post Comments"
        userCommentsView.configureHeaderView(userPost: viewModel?.userPost)
        self.userCommentsView.tableView.register(UserCommentsTableViewCell.self, forCellReuseIdentifier: "UserCommentsTableViewCell")
        self.userCommentsView.tableView.dataSource = self
        self.userCommentsView.tableView.delegate = self
        self.viewModel?.delegate = self
        self.viewModel?.fetchCommentsForPost()
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate

extension UserCommentsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        self.viewModel?.postComments?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        80.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserCommentsTableViewCell", for: indexPath) as? UserCommentsTableViewCell, let postComment = viewModel?.postComments?[indexPath.row] else {
            
            fatalError("Unable to dequeue UserPostTableViewCell")
        }
        
        cell.configure(comment: postComment)
        return cell
    }
}

extension UserCommentsViewController : UserPostCommentsViewModelDelegate {
    

    /// Notifies the view controller that user post comments are ready to be presented. Reloads the table view to display the comments.
         
    func presentUserPostComments() {
        
        DispatchQueue.main.async {
            
            self.userCommentsView.tableView.reloadData()
        }
    }
    
    
    /// Notifies the view controller that there was a failure in fetching user post comments.
       
    func presentFailureScreen() {
        
        let alertController = UIAlertController(title: "My Posts", message: "Somehting went wrong", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
          alertController.addAction(okAction)
        
          self.present(alertController, animated: true, completion: nil)
    }
    
}


