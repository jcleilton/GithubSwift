//
//  MainViewTableViewCell.swift
//  GithubSwift
//
//  Created by Cleilton Feitosa on 15/11/20.
//  Copyright © 2020 Cleilton Feitosa. All rights reserved.
//

import UIKit

class MainViewTableViewCell: UITableViewCell {
    static let identifier: String = "MainViewTableViewCell"
    
    lazy var mainView: UIView = {
        let obj = UIView()
        obj.clipsToBounds = true
        obj.layer.cornerRadius = 15
        return obj
    }()
    
    lazy var photoImageView: UIImageView = {
        let obj = UIImageView()
        obj.contentMode = .scaleAspectFill
        obj.clipsToBounds = true
        return obj
    }()
    
    lazy var starImageView: UIImageView = {
        let obj = UIImageView()
        obj.image = UIImage(named: "star")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        obj.tintColor = .yellow
        obj.contentMode = .scaleAspectFit
        return obj
    }()
    
    lazy var repoNameLabel: UILabel = {
        let obj = UILabel()
        obj.text = Constant.string.REPO_NAME
        obj.font = Constant.font.TITLE_LABEL
        obj.setContentHuggingPriority(.defaultHigh, for: NSLayoutConstraint.Axis.horizontal)
        obj.textAlignment = .left
        obj.textColor = .white
        return obj
    }()
    
    lazy var repoNameValueLabel: UILabel = {
        let obj = UILabel()
        obj.font = Constant.font.TITLE_LABEL
        obj.textAlignment = .left
        obj.textColor = .white
        return obj
    }()
    
    lazy var authorNameLabel: UILabel = {
        let obj = UILabel()
        obj.text = Constant.string.AUTHOR_NAME
        obj.textAlignment = .left
        obj.setContentHuggingPriority(.defaultHigh, for: NSLayoutConstraint.Axis.horizontal)
        obj.font = Constant.font.LABEL
        obj.textColor = .white
        return obj
    }()
    
    lazy var authorNameValueLabel: UILabel = {
        let obj = UILabel()
        obj.font = Constant.font.LABEL
        obj.textAlignment = .left
        obj.textColor = .white
        return obj
    }()
    
    lazy var starQuantityLabel: UILabel = {
        let obj = UILabel()
        obj.font = Constant.font.TITLE_LABEL
        obj.textColor = .yellow
        obj.textAlignment = .right
        return obj
    }()
    
    override func didMoveToSuperview() {
        DispatchQueue.main.async {
            self.setupCell()
        }
    }
    
    private func setupCell() {
        self.contentView.backgroundColor = .clear
        self.backgroundColor = .clear
        
        self.mainView.backgroundColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.3)
        
        self.contentView.addSubview(self.mainView)
        self.mainView.addSubview(self.photoImageView)
        self.mainView.addSubview(self.starImageView)
        self.mainView.addSubview(self.repoNameLabel)
        self.mainView.addSubview(self.repoNameValueLabel)
        self.mainView.addSubview(self.authorNameLabel)
        self.mainView.addSubview(self.authorNameValueLabel)
        self.mainView.addSubview(self.starQuantityLabel)
        
        self.mainView.translatesAutoresizingMaskIntoConstraints = false
        self.photoImageView.translatesAutoresizingMaskIntoConstraints = false
        self.starImageView.translatesAutoresizingMaskIntoConstraints = false
        self.repoNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.repoNameValueLabel.translatesAutoresizingMaskIntoConstraints = false
        self.authorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.authorNameValueLabel.translatesAutoresizingMaskIntoConstraints = false
        self.starQuantityLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.mainView.anchor(
            top: (anchor: self.contentView.topAnchor, constant: 10),
            bottom: (anchor: self.contentView.bottomAnchor, constant: -10),
            left: (anchor: self.contentView.leftAnchor, constant: 10),
            right: (anchor: self.contentView.rightAnchor, constant: -10))
        
        self.photoImageView.anchor(
            top: (anchor: self.mainView.topAnchor, constant: 0),
            left: (anchor: self.mainView.leftAnchor, constant: 0),
            right: (anchor: self.mainView.rightAnchor, constant: 0),
            relativeHeight: (anchor: self.mainView.heightAnchor, multiplier: 0.8, constant: 0))
        
        self.repoNameLabel.anchor(
            top: (anchor: self.photoImageView.bottomAnchor, constant: 15),
            left: (anchor: self.mainView.leftAnchor, constant: 10))
        
        self.repoNameValueLabel.anchor(
            centerY: (anchor: self.repoNameLabel.centerYAnchor, constant: 0),
            left: (anchor: self.repoNameLabel.rightAnchor, constant: 5),
            right: (anchor: self.mainView.rightAnchor, constant: -5))
        
        self.authorNameLabel.anchor(
            top: (anchor: self.repoNameLabel.bottomAnchor, constant: 8),
            left: (anchor: self.repoNameLabel.leftAnchor, constant: 0))
        
        self.authorNameValueLabel.anchor(
            centerY: (anchor: self.authorNameLabel.centerYAnchor, constant: 0),
            left: (anchor: self.authorNameLabel.rightAnchor, constant: 5),
            right: (anchor: self.starQuantityLabel.leftAnchor, constant: 5))
        
        self.starImageView.anchor(
            centerY: (anchor: self.authorNameLabel.centerYAnchor, constant: -6),
            right: (anchor: self.mainView.rightAnchor, constant: -10))
        
        self.starImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.starImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.starQuantityLabel.anchor(
            centerY: (anchor: self.authorNameValueLabel.centerYAnchor, constant: 0),
            right: (anchor: self.starImageView.leftAnchor, constant: -8))
        
        self.updateConstraints()
    }
    
    func configure(with viewModel: MainViewTableViewCellViewModel) {
        DispatchQueue.main.async { [viewModel] in
            self.repoNameValueLabel.text = viewModel.repoName
            self.authorNameValueLabel.text = viewModel.authorName
            self.starQuantityLabel.text = "\(viewModel.stargazersCount)"
            viewModel.delegate = self
            self.photoImageView.image = UIImage(named: "placeholder")
            viewModel.loadImage()
        }
        
    }
}

extension MainViewTableViewCell: DownloadImageDataDelegate {
    func didLoadImage(data: Data) {
        DispatchQueue.main.async {
            let image = UIImage(data: data)
            self.photoImageView.image = image
        }
    }
    
    func didFailLoadingImage() {
        self.photoImageView.image = UIImage(named: "placeholder")
    }
}
