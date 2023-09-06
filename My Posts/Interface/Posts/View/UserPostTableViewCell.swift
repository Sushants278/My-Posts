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
    
    struct ViewTraits {
        
        static let postTitleLabelLeading: CGFloat = 16
        static let postTitleLabelTrailingToFavoriteButton: CGFloat = -16
        static let postTitleLabelTop: CGFloat = 10
        static let postTitleLabelHeight: CGFloat = 20
        
        static let bodyLabelLeading: CGFloat = 16
        static let bodyLabelTrailingToFavoriteButton: CGFloat = -16
        static let bodyLabelTopToPostTitleLabel: CGFloat = 10
        static let bodyLabelHeight: CGFloat = 20
        
        static let favoriteButtonTrailing: CGFloat = -16
        static let favoriteButtonCenterY: CGFloat = 0
        static let favoriteButtonWidth: CGFloat = 30
        static let favoriteButtonHeight: CGFloat = 30
    }
    
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
            postTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ViewTraits.postTitleLabelLeading),
            postTitleLabel.trailingAnchor.constraint(equalTo: favouriteButton.leadingAnchor, constant: ViewTraits.postTitleLabelTrailingToFavoriteButton),
            postTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: ViewTraits.postTitleLabelTop),
            postTitleLabel.heightAnchor.constraint(equalToConstant: ViewTraits.postTitleLabelHeight),
            
            bodyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ViewTraits.bodyLabelLeading),
            bodyLabel.trailingAnchor.constraint(equalTo: favouriteButton.leadingAnchor, constant: ViewTraits.bodyLabelTrailingToFavoriteButton),
            bodyLabel.topAnchor.constraint(equalTo: postTitleLabel.bottomAnchor, constant: ViewTraits.bodyLabelTopToPostTitleLabel),
            bodyLabel.heightAnchor.constraint(equalToConstant: ViewTraits.bodyLabelHeight),
            
            favouriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: ViewTraits.favoriteButtonTrailing),
            favouriteButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: ViewTraits.favoriteButtonCenterY),
            favouriteButton.widthAnchor.constraint(equalToConstant: ViewTraits.favoriteButtonWidth),
            favouriteButton.heightAnchor.constraint(equalToConstant: ViewTraits.favoriteButtonHeight)
        ])
    }
    

    /// Configures the cell with the provided user post data and updates the UI elements accordingly.
    /// - Parameter userPost: The user post to be displayed in the cell.
    
    func configure(with userPost: UserPost) {
        
        self.userPost = userPost
        postTitleLabel.text = userPost.title
        bodyLabel.text = userPost.body
        let isFavorite = userPost.isFavorite ?? false
        let image = UIImage(systemName: isFavorite ? "suit.heart.fill" : "suit.heart")
        favouriteButton.setBackgroundImage(image, for: .normal)
    }
    
   
    /// Toggles the selection state of the favorite button and notifies the delegate.
    
    @objc private func favouriteButtonTapped() {
        
        guard let userPost = self.userPost else {
            
            return
        }
        
        favouriteButton.isSelected.toggle()
        delegate?.didTapFavouriteButton(userPost: userPost)
    }
}
