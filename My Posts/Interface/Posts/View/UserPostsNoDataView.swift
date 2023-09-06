//
//  UserPostsNoDataView.swift
//  My Posts
//
//  Created by Sushant Shinde on 05.09.23.
//

import UIKit

class UserPostsNoDataView: UIView {
    
    
    struct ViewTraits {
        
        static let imageViewWidth: CGFloat = 100
        static let imageViewHeight: CGFloat = 100
        static let messageLabelTopSpace: CGFloat = 16
    }

    // MARK: - UI Elements
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "heart.circle")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let messageLabel: UILabel = {
        let messageLabel = UILabel()
        messageLabel.text = "No favorite post to display"
        messageLabel.textAlignment = .center
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        return messageLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }

    private func configureView() {
      
        addSubview(imageView)
        addSubview(messageLabel)

        NSLayoutConstraint.activate([
            
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -ViewTraits.imageViewHeight / 2),
            imageView.widthAnchor.constraint(equalToConstant: ViewTraits.imageViewWidth),
            imageView.heightAnchor.constraint(equalToConstant: ViewTraits.imageViewHeight),

            messageLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: ViewTraits.messageLabelTopSpace),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: ViewTraits.messageLabelTopSpace),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -ViewTraits.messageLabelTopSpace),
        ])

    }
}

