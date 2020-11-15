//
//  MainModel.swift
//  GithubSwift
//
//  Created by Cleilton Feitosa on 15/11/20.
//  Copyright © 2020 Cleilton Feitosa. All rights reserved.
//

import Foundation
import GithubSwiftApi

struct MainModel {
    let userID: Int
    let authorPhotoURL: String
    let authorName: String
    let repoID: Int
    let repoName: String
    let stargazersCount: Int
    let itemDescription: String
    let sshURL: String
    let cloneURL: String
    let watchersCount: Int
    let score: Int
    
    func downloadImage(completion: @escaping((Data?) -> Void)) {
        let api = GithubSwiftApi()
        api.getImage(url: authorPhotoURL) { result in
            switch result {
            case .success(let data):
                completion(data)
            case .failure(_):
                completion(nil)
            }
        }
    }
}
