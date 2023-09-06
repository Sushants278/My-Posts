//
//  UserCommentsView.swift
//  My Posts
//
//  Created by Sushant Shinde on 05.09.23.
//

import UIKit

class UserCommentsView: UIView {
    
    struct ViewTraits {
        
        static let headerViewTopSpace: CGFloat = 100
        static let headerViewHeight: CGFloat = 150
        static let tableViewTopSpace: CGFloat = 10
        static let tableViewLeadingSpace: CGFloat = 20
        static let tableViewTrailingSpace: CGFloat = -20
    }
    
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
            headerView.topAnchor.constraint(equalTo: self.topAnchor, constant: ViewTraits.headerViewTopSpace),
            headerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: ViewTraits.headerViewHeight),
            
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: ViewTraits.tableViewTopSpace),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ViewTraits.tableViewLeadingSpace),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ViewTraits.tableViewTrailingSpace),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            noDataView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            noDataView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            noDataView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            noDataView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
   
    /// Configures the header view of the user posts screen with the provided user post data.
    /// - Parameters:- userPost: The user post containing data for the header view.

    func configureHeaderView(userPost: UserPost?) {
        
        headerView.configure(title: userPost?.title ?? "",
                               subtitle: userPost?.body ?? "")
    }
}
