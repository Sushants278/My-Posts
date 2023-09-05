//
//  UserCommentsViewController.swift
//  My Posts
//
//  Created by Sushant Shinde on 05.09.23.
//

import UIKit

class UserCommentsViewController: UIViewController {
    
    var viewModel: UserCommentsViewModel?
    
    init(viewModel: UserCommentsViewModel? = nil) {
        
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.viewModel?.fetchCommentsForPost()
    }
    
}
