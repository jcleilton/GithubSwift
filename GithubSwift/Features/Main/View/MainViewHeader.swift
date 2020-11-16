//
//  MainViewHeader.swift
//  GithubSwift
//
//  Created by Cleilton Feitosa on 15/11/20.
//  Copyright © 2020 Cleilton Feitosa. All rights reserved.
//

import UIKit

class MainViewHeader: UIView {
    lazy var catImageView: UIImageView = {
        let obj = UIImageView()
        obj.image = Constant.image.cat
        obj.contentMode = .scaleAspectFill
        return obj
    }()
    
    lazy var titleLabel: UILabel = {
        let obj = UILabel()
        obj.text = Constant.string.appName
        obj.font = Constant.font.titleLabel
        obj.textAlignment = .center
        obj.textColor = Constant.color.orange
        obj.backgroundColor = Constant.color.backgroundColorDarkWithAlpha
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
        
        self.clipsToBounds = true
        
        self.backgroundColor = Constant.color.clean
        
        self.addSubview(self.catImageView)
        self.addSubview(self.titleLabel)
        
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.catImageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.titleLabel.anchorFillSuperview()
        
        self.catImageView.anchorFillSuperview()
    }
}
