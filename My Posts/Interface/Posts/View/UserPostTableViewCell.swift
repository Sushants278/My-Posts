//
//  UserPostTableViewCell.swift
//  My Posts
//
//  Created by Sushant Shinde on 04.09.23.
//

import UIKit

protocol UserPostTableViewDelegate: AnyObject {
    
    func didTapFavouriteButton(userPost: UserPost)
}

class UserPostTableViewCell: UITableViewCell {
    
     private var userPost: UserPost?
     weak var delegate: UserPostTableViewDelegate?
    
    // MARK: - UI Elements
    
    let postTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let favouriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        
        contentView.addSubview(postTitleLabel)
        contentView.addSubview(favouriteButton)
        
        self.selectionStyle = .none
        
        let filledHeartImage = UIImage(systemName: "heart.fill")
        let unfilledHeartImage = UIImage(systemName: "heart")
        
        favouriteButton.setImage(unfilledHeartImage, for: .normal)
        favouriteButton.setImage(filledHeartImage, for: .selected)
        
        favouriteButton.addTarget(self, action: #selector(favouriteButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            
            postTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            postTitleLabel.trailingAnchor.constraint(equalTo: favouriteButton.leadingAnchor, constant: -16),
            postTitleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            favouriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            favouriteButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            favouriteButton.widthAnchor.constraint(equalToConstant: 35),
            favouriteButton.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    // MARK: - Configure Cell
    
    func configure(with userPost: UserPost) {
        
        self.userPost = userPost
        postTitleLabel.text = userPost.title
        favouriteButton.isSelected = userPost.isFavorite ?? false
    }
    
    @objc private func favouriteButtonTapped() {
        
        guard let userPost = self.userPost else {
            
            return
        }
        
        favouriteButton.isSelected.toggle()
        delegate?.didTapFavouriteButton(userPost: userPost)
    }
}
