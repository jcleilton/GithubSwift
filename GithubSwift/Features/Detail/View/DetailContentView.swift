//
//  DetailContentView.swift
//  GithubSwift
//
//  Created by Cleilton Feitosa on 15/11/20.
//  Copyright © 2020 Cleilton Feitosa. All rights reserved.
//

import UIKit

class DetailContentView: UIView {
    lazy var repoDescriptionLabel: UILabel = {
        let obj = UILabel()
        obj.font = Constant.font.descriptionLabel
        obj.setContentHuggingPriority(.defaultHigh, for: NSLayoutConstraint.Axis.horizontal)
        obj.textAlignment = .center
        obj.numberOfLines = 0
        obj.textColor = Constant.color.main
        return obj
    }()
    
    init() {
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        self.backgroundColor = Constant.color.label
        
        self.addSubview(self.repoDescriptionLabel)
        
        self.repoDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.repoDescriptionLabel.anchorFillSuperview()
    }
    
    func setup(with viewModel: DetailViewModel) {
        self.repoDescriptionLabel.text = viewModel.itemDescription
    }
}
