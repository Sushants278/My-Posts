//
//  UserPostsView.swift
//  My Posts
//
//  Created by Sushant Shinde on 04.09.23.
//

import UIKit

class UserPostsView: UIView {
    
    struct ViewTraits {
        
        static let headerViewTopSpace: CGFloat = 80
        static let headerViewHeight: CGFloat = 50
    }
    
    // MARK: - UI Elements

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let headerView: UserPostsHeaderView = {
        let headerView = UserPostsHeaderView()
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
            
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            noDataView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            noDataView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            noDataView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            noDataView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yOffset = scrollView.contentOffset.y
        if yOffset < 0 {
            
            headerView.frame.origin.y = 0
        } else {
            
            headerView.frame.origin.y = -yOffset
        }
    }
}
