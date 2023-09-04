//
//  UserPostTableViewCell.swift
//  My Posts
//
//  Created by Sushant Shinde on 04.09.23.
//

import UIKit

class UserPostTableViewCell: UITableViewCell {
    
    
    // MARK: - UI Elements
    
    let postLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0 
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        
    contentView.addSubview(postLabel)
        
       NSLayoutConstraint.activate([
            postLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            postLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            postLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            postLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    // MARK: - Configure Cell
    
    func configure(with userPost: UserPost?) {
        
        postLabel.text = userPost?.title
    }
}
