//
//  UserCommentsTableViewCell.swift
//  My Posts
//
//  Created by Sushant Shinde on 05.09.23.
//

import UIKit

class UserCommentsTableViewCell: UITableViewCell {
    
    struct ViewTraits {
        
        static let stackViewTopAnchorConstant: CGFloat = 8
        static let stackViewLeadingAnchorConstant: CGFloat = 16
        static let stackViewTrailingAnchorConstant: CGFloat = -16
        static let stackViewBottomAnchorConstant: CGFloat = -16
    }
    
    // MARK: - UI Elements
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let commentLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    
    private func setupUI() {
        
        stackView.addArrangedSubview(emailLabel)
        stackView.addArrangedSubview(commentLabel)
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: ViewTraits.stackViewTopAnchorConstant),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ViewTraits.stackViewLeadingAnchorConstant),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: ViewTraits.stackViewTrailingAnchorConstant),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: ViewTraits.stackViewBottomAnchorConstant)
        ])
    }
    
    
    /// Configures the UserCommentTableViewCell with the provided UserComment data.
    /// - Parameter comment: The UserComment object containing the comment details to be displayed.
    
    func configure(comment: UserComment) {
        emailLabel.text = comment.email
        commentLabel.text = comment.body
    }
}
