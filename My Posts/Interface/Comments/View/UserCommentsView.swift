//
//  UserCommentsView.swift
//  My Posts
//
//  Created by Sushant Shinde on 05.09.23.
//

import UIKit

class UserCommentsView: UIView {
    
    // MARK: - UI Elements
    

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let headerView: UserCommentsHeaderView = {
        let headerView = UserCommentsHeaderView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        return headerView
    }()
    
    let noDataView: UserPostsNoDataView = {
        let noDataView = UserPostsNoDataView()
        noDataView.isHidden = true
        noDataView.translatesAutoresizingMaskIntoConstraints = false
        return noDataView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        
        
        addSubview(headerView)
        addSubview(tableView)
        addSubview(noDataView)
        
        NSLayoutConstraint.activate([
            
            headerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),
            headerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 150),
            
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            noDataView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            noDataView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            noDataView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            noDataView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
    }
    
    func configureHeaderView(userPost: UserPost?) {
        
        headerView.configure(title: userPost?.title ?? "", subtitle: userPost?.body ?? "")
    }
}
