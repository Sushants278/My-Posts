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
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let favouriteButton: UIButton = {
        let button = UIButton(type: .custom)
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
        contentView.addSubview(bodyLabel)
        contentView.addSubview(favouriteButton)
        
        self.selectionStyle = .none
        
        favouriteButton.addTarget(self, action: #selector(favouriteButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            
            postTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            postTitleLabel.trailingAnchor.constraint(equalTo: favouriteButton.leadingAnchor, constant: -16),
            postTitleLabel.topAnchor.constraint(equalTo:contentView.topAnchor, constant: 10),
            postTitleLabel.heightAnchor.constraint(equalToConstant: 20),

            
            bodyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            bodyLabel.trailingAnchor.constraint(equalTo: favouriteButton.leadingAnchor, constant: -16),
            bodyLabel.topAnchor.constraint(equalTo:postTitleLabel.bottomAnchor, constant: 10),
            bodyLabel.heightAnchor.constraint(equalToConstant: 20),
            
            favouriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            favouriteButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            favouriteButton.widthAnchor.constraint(equalToConstant: 30),
            favouriteButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    // MARK: - Configure Cell
    
    func configure(with userPost: UserPost) {
        
        self.userPost = userPost
        postTitleLabel.text = userPost.title
        bodyLabel.text = userPost.body
        let isFavorite = userPost.isFavorite ?? false
        let image = UIImage(systemName: isFavorite ? "suit.heart.fill" : "suit.heart")
        favouriteButton.setBackgroundImage(image, for: .normal)

    }
    
    
    @objc private func favouriteButtonTapped() {
        
        guard let userPost = self.userPost else {
            
            return
        }
        
        favouriteButton.isSelected.toggle()
        delegate?.didTapFavouriteButton(userPost: userPost)
    }
}
