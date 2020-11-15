//
//  MainModelApiParse.swift
//  GithubSwift
//
//  Created by Cleilton Feitosa on 15/11/20.
//  Copyright © 2020 Cleilton Feitosa. All rights reserved.
//

import Foundation
import GithubSwiftApi

struct MainModelApiParse {
    static func get(from apiModel: GithubSwiftResponse) -> [MainModel] {
        apiModel.items.compactMap{ MainModel(
            userID: $0.owner.id,
            authorPhotoURL: $0.owner.avatarURL,
            authorName: $0.owner.login,
            repoID: $0.id,
            repoName: $0.name,
            stargazersCount: $0.stargazersCount,
            itemDescription: $0.itemDescription,
            sshURL: $0.sshURL,
            cloneURL: $0.cloneURL,
            watchersCount: $0.watchersCount,
            score: $0.score) }
    }
    
    static func getMessage(from error: GithubSwiftError) -> String {
        switch error {
        case .badURL:
            return Constant.string.badURL
        case .taskError:
            return Constant.string.taskError
        case .noResponse:
            return Constant.string.noResponse
        case .invalidStatusCode(let code):
            return Constant.string.invalidStatusCode("\(code)")
        case .noData:
            return Constant.string.noData
        case .invalidJSON:
            return Constant.string.invalidJson
        case .noMorePages:
            return ""
        }
    }
}
