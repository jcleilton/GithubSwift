//
//  DetailHeaderView.swift
//  GithubSwift
//
//  Created by Cleilton Feitosa on 15/11/20.
//  Copyright © 2020 Cleilton Feitosa. All rights reserved.
//

import UIKit

class DetailHeaderView: UIView {
    lazy var closeButton: UIButton = {
        let obj = UIButton()
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
    
    init() {
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        self.backgroundColor = Constant.color.clean
        
        self.backgroundColor = Constant.color.backgroundColorWithAlpha
        
        self.addSubview(self.photoImageView)
        self.addSubview(self.starImageView)
        self.addSubview(self.repoNameLabel)
        self.addSubview(self.repoNameValueLabel)
        self.addSubview(self.authorNameLabel)
        self.addSubview(self.authorNameValueLabel)
        self.addSubview(self.starQuantityLabel)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.photoImageView.translatesAutoresizingMaskIntoConstraints = false
        self.starImageView.translatesAutoresizingMaskIntoConstraints = false
        self.repoNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.repoNameValueLabel.translatesAutoresizingMaskIntoConstraints = false
        self.authorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.authorNameValueLabel.translatesAutoresizingMaskIntoConstraints = false
        self.starQuantityLabel.translatesAutoresizingMaskIntoConstraints = false
                
        self.photoImageView.anchor(
            top: (anchor: self.topAnchor, constant: Constant.distance.zero),
            left: (anchor: self.leftAnchor, constant: Constant.distance.zero),
            right: (anchor: self.rightAnchor, constant: Constant.distance.zero),
            relativeHeight: (anchor: self.heightAnchor, multiplier: 0.78, constant: Constant.distance.zero))
        
        self.repoNameLabel.anchor(
            top: (anchor: self.photoImageView.bottomAnchor, constant: Constant.distance.vertical.big),
            left: (anchor: self.leftAnchor, constant: Constant.distance.horizontal.normal))
        
        self.repoNameValueLabel.anchor(
            centerY: (anchor: self.repoNameLabel.centerYAnchor, constant: Constant.distance.zero),
            left: (anchor: self.repoNameLabel.rightAnchor, constant: Constant.distance.horizontal.extraSmall),
            right: (anchor: self.rightAnchor, constant: -Constant.distance.horizontal.extraSmall))
        
        self.authorNameLabel.anchor(
            top: (anchor: self.repoNameLabel.bottomAnchor, constant: Constant.distance.vertical.small),
            left: (anchor: self.repoNameLabel.leftAnchor, constant: Constant.distance.zero))
        
        self.authorNameValueLabel.anchor(
            centerY: (anchor: self.authorNameLabel.centerYAnchor, constant: Constant.distance.zero),
            left: (anchor: self.authorNameLabel.rightAnchor, constant: Constant.distance.horizontal.extraSmall),
            right: (anchor: self.starQuantityLabel.leftAnchor, constant: Constant.distance.horizontal.extraSmall))
        
        self.authorNameLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -2).isActive = true
        
        self.starImageView.anchor(
            centerY: (anchor: self.authorNameLabel.centerYAnchor, constant: -Constant.distance.vertical.small),
            right: (anchor: self.rightAnchor, constant: -Constant.distance.horizontal.normal))
        
        self.starImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.starImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.starQuantityLabel.anchor(
            centerY: (anchor: self.authorNameValueLabel.centerYAnchor, constant: Constant.distance.zero),
            right: (anchor: self.starImageView.leftAnchor, constant: -Constant.distance.horizontal.small))
        
        self.updateConstraints()
    }
    
    func setup(with viewModel: DetailViewModel) {
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

extension DetailHeaderView: DownloadImageDataDelegate {
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
