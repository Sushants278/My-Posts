//
//  UserCommentsHeaderView.swift
//  My Posts
//
//  Created by Sushant Shinde on 05.09.23.
//

import UIKit

class UserCommentsHeaderView: UIView {
    
    struct ViewTraits {
        
        static let containerViewTop: CGFloat = 16
        static let containerViewLeading: CGFloat = 16
        static let containerViewTrailing: CGFloat = -16
        static let containerViewBottom: CGFloat = 0
        
        static let titleLabelTop: CGFloat = 20
        static let titleLabelLeading: CGFloat = 20
        static let titleLabelTrailing: CGFloat = -20
        
        static let subtitleLabelTop: CGFloat = 10
        static let subtitleLabelLeading: CGFloat = 20
        static let subtitleLabelTrailing: CGFloat = -20
        static let subtitleLabelBottom: CGFloat = -20
    }
    
    // MARK: - UI Elements
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 82/255, green: 144/255, blue: 255/255, alpha: 1.0)
        view.layer.cornerRadius = 15
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        return view
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(subtitleLabel)
        addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: ViewTraits.containerViewTop),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: ViewTraits.containerViewLeading),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: ViewTraits.containerViewTrailing),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: ViewTraits.containerViewBottom),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: ViewTraits.titleLabelTop),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: ViewTraits.titleLabelLeading),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: ViewTraits.titleLabelTrailing),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: ViewTraits.subtitleLabelTop),
            subtitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: ViewTraits.subtitleLabelLeading),
            subtitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: ViewTraits.subtitleLabelTrailing),
            subtitleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: ViewTraits.subtitleLabelBottom),
        ])
    }
    
    /// Configures the header view with the provided title and subtitle text.
    /// - Parameters:
    ///   - title: The title text to display.
    ///   - subtitle: The subtitle text to display.
    ///
    func configure(title: String, subtitle: String) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }
}
