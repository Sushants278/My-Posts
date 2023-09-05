//
//  UserPostsHeaderView.swift
//  My Posts
//
//  Created by Sushant Shinde on 04.09.23.
//

import UIKit

protocol HeaderViewDelegate: AnyObject {
    
    func segmentedControlValueChanged(_ selectedIndex: Int)
}

class UserPostsHeaderView: UIView {
    
    weak var delegate: HeaderViewDelegate?
    
    let segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["All", "Favorites"])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0 // Set the initial selected segment
        return segmentedControl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        
        backgroundColor = .white
        
        addSubview(segmentedControl)
        
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        
        NSLayoutConstraint.activate([
            segmentedControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            segmentedControl.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    @objc private func segmentedControlValueChanged() {
        
        delegate?.segmentedControlValueChanged(segmentedControl.selectedSegmentIndex)
    }
}

