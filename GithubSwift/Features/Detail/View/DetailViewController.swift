//
//  DetailViewController.swift
//  GithubSwift
//
//  Created by Cleilton Feitosa on 15/11/20.
//  Copyright © 2020 Cleilton Feitosa. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var viewModel: DetailViewModel
    
    lazy var headerView: DetailHeaderView = DetailHeaderView()
    
    lazy var contentView: DetailContentView = DetailContentView()
    
    lazy var scrollView: UIScrollView = {
        let obj = UIScrollView()
        return obj
    }()
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Constant.color.main
        self.setupView()
    }
    
    private func setupView() {
        self.view.addSubview(self.scrollView)
        
        self.scrollView.addSubview(self.headerView)
        self.scrollView.addSubview(self.contentView)
        
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.headerView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        
        self.scrollView.anchorFillSuperview()
        
        self.headerView.anchor(
            top: (anchor: self.scrollView.frameLayoutGuide.topAnchor, constant: Constant.distance.zero),
            left: (anchor: self.view.leftAnchor, constant: Constant.distance.zero),
            right: (anchor: self.view.rightAnchor, constant: Constant.distance.zero),
            relativeHeight: (anchor: self.headerView.widthAnchor, multiplier: 1, constant: Constant.distance.zero))
        
        self.contentView.anchor(
            top: (anchor: self.headerView.bottomAnchor, constant: Constant.distance.zero),
            bottom: (anchor: self.scrollView.frameLayoutGuide.bottomAnchor, constant: Constant.distance.zero),
            left: (anchor: self.view.leftAnchor, constant: Constant.distance.zero),
            right: (anchor: self.view.rightAnchor, constant: Constant.distance.zero))
        
        self.headerView.setup(with: self.viewModel)
        self.contentView.setup(with: self.viewModel)
        
        self.view.updateConstraints()
    }
}
