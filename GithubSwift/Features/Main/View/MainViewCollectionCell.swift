//
//  MainViewCollectionCell.swift
//  GithubSwift
//
//  Created by Cleilton Feitosa on 15/11/20.
//  Copyright © 2020 Cleilton Feitosa. All rights reserved.
//

import UIKit

class MainViewCollectionCell: UICollectionViewCell {
    func configure(with viewModel: MainViewCollectionCellViewModel) {
        
    }
}

extension MainViewCollectionCell: DownloadImageDataDelegate {
    func didLoadImage(data: Data) {
        
    }
    
    func didFailLoadingImage() {
        
    }
}
