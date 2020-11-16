//
//  MainViewTableViewCellViewModel.swift
//  GithubSwift
//
//  Created by Cleilton Feitosa on 15/11/20.
//  Copyright © 2020 Cleilton Feitosa. All rights reserved.
//

import Foundation

protocol DownloadImageDataDelegate: AnyObject {
    func didLoadImage(data: Data)
    func didFailLoadingImage()
}

class MainViewTableViewCellViewModel {
    weak var delegate: DownloadImageDataDelegate?
    private let model: MainModel
    var userID: Int {
        model.userID
    }
    var authorName: String {
        model.authorName
    }
    var repoID: Int {
        model.repoID
    }
    var repoName: String {
        model.repoName
    }
    var stargazersCount: Int {
        model.stargazersCount
    }
    var itemDescription: String {
        model.itemDescription
    }
    var sshURL: String {
        model.sshURL
    }
    var cloneURL: String {
        model.cloneURL
    }
    var score: Int {
        model.score
    }
    private var imageData: Data? = nil
    
    init(model: MainModel) {
        self.model = model
    }
    
    func loadImage() {
        guard let imageDataUnwrapped = self.imageData else {
            model.downloadImage { [weak self] imageData in
                guard let imageData = imageData else {
                    self?.delegate?.didFailLoadingImage()
                    return
                }
                self?.imageData = imageData
                self?.delegate?.didLoadImage(data: imageData)
            }
            return
        }
        self.delegate?.didLoadImage(data: imageDataUnwrapped)
    }
    
    func parseToDetailViewModel() -> DetailViewModel {
        DetailViewModel(model: model, imageData: imageData)
    }
}
