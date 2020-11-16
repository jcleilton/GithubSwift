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
        obj.image = Constant.image.star?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        obj.tintColor = Constant.color.starColor
        obj.contentMode = .scaleAspectFit
        return obj
    }()
    
    lazy var repoNameLabel: UILabel = {
        let obj = UILabel()
        obj.text = Constant.string.repoName
        obj.font = Constant.font.titleLabel
        obj.setContentHuggingPriority(.defaultHigh, for: NSLayoutConstraint.Axis.horizontal)
        obj.textAlignment = .left
        obj.textColor = Constant.color.titleLabel
        return obj
    }()
    
    lazy var repoNameValueLabel: UILabel = {
        let obj = UILabel()
        obj.font = Constant.font.titleLabel
        obj.textAlignment = .left
        obj.textColor = Constant.color.titleLabel
        return obj
    }()
    
    lazy var authorNameLabel: UILabel = {
        let obj = UILabel()
        obj.text = Constant.string.authorName
        obj.textAlignment = .left
        obj.setContentHuggingPriority(.defaultHigh, for: NSLayoutConstraint.Axis.horizontal)
        obj.font = Constant.font.label
        obj.textColor = Constant.color.label
        return obj
    }()
    
    lazy var authorNameValueLabel: UILabel = {
        let obj = UILabel()
        obj.font = Constant.font.label
        obj.textAlignment = .left
        obj.textColor = Constant.color.label
        return obj
    }()
    
    lazy var starQuantityLabel: UILabel = {
        let obj = UILabel()
        obj.font = Constant.font.titleLabel
        obj.textColor = Constant.color.starColor
        obj.textAlignment = .right
        return obj
    }()
    
    override func didMoveToSuperview() {
        DispatchQueue.main.async {
            self.setupCell()
        }
    }
    
    private func setupCell() {
        self.contentView.backgroundColor = Constant.color.clean
        self.backgroundColor = Constant.color.clean
        
        self.mainView.backgroundColor = Constant.color.backgroundColorWithAlpha
        
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
            top: (anchor: self.contentView.topAnchor, constant: Constant.distance.vertical.normal),
            bottom: (anchor: self.contentView.bottomAnchor, constant: -Constant.distance.vertical.normal),
            left: (anchor: self.contentView.leftAnchor, constant: Constant.distance.horizontal.normal),
            right: (anchor: self.contentView.rightAnchor, constant: -Constant.distance.horizontal.normal))
        
        self.photoImageView.anchor(
            top: (anchor: self.mainView.topAnchor, constant: Constant.distance.zero),
            left: (anchor: self.mainView.leftAnchor, constant: Constant.distance.zero),
            right: (anchor: self.mainView.rightAnchor, constant: Constant.distance.zero),
            relativeHeight: (anchor: self.mainView.heightAnchor, multiplier: 0.8, constant: Constant.distance.zero))
        
        self.repoNameLabel.anchor(
            top: (anchor: self.photoImageView.bottomAnchor, constant: Constant.distance.vertical.big),
            left: (anchor: self.mainView.leftAnchor, constant: Constant.distance.horizontal.normal))
        
        self.repoNameValueLabel.anchor(
            centerY: (anchor: self.repoNameLabel.centerYAnchor, constant: Constant.distance.zero),
            left: (anchor: self.repoNameLabel.rightAnchor, constant: Constant.distance.horizontal.extraSmall),
            right: (anchor: self.mainView.rightAnchor, constant: -Constant.distance.horizontal.extraSmall))
        
        self.authorNameLabel.anchor(
            top: (anchor: self.repoNameLabel.bottomAnchor, constant: Constant.distance.vertical.small),
            left: (anchor: self.repoNameLabel.leftAnchor, constant: Constant.distance.zero))
        
        self.authorNameValueLabel.anchor(
            centerY: (anchor: self.authorNameLabel.centerYAnchor, constant: Constant.distance.zero),
            left: (anchor: self.authorNameLabel.rightAnchor, constant: Constant.distance.horizontal.extraSmall),
            right: (anchor: self.starQuantityLabel.leftAnchor, constant: Constant.distance.horizontal.extraSmall))
        
        self.starImageView.anchor(
            centerY: (anchor: self.authorNameLabel.centerYAnchor, constant: -Constant.distance.vertical.small),
            right: (anchor: self.mainView.rightAnchor, constant: -Constant.distance.horizontal.normal))
        
        self.starImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.starImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.starQuantityLabel.anchor(
            centerY: (anchor: self.authorNameValueLabel.centerYAnchor, constant: Constant.distance.zero),
            right: (anchor: self.starImageView.leftAnchor, constant: -Constant.distance.horizontal.small))
        
        self.updateConstraints()
    }
    
    func configure(with viewModel: MainViewTableViewCellViewModel) {
        DispatchQueue.main.async { [viewModel] in
            self.repoNameValueLabel.text = viewModel.repoName
            self.authorNameValueLabel.text = viewModel.authorName
            self.starQuantityLabel.text = "\(viewModel.stargazersCount)"
            viewModel.delegate = self
            self.photoImageView.image = Constant.image.placeholder
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
        self.photoImageView.image = Constant.image.placeholder
    }
}
