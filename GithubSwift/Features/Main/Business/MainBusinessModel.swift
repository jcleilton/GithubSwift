//
//  MainBusinessModel.swift
//  GithubSwift
//
//  Created by Cleilton Feitosa on 13/11/20.
//  Copyright © 2020 Cleilton Feitosa. All rights reserved.
//

import Foundation
import GithubSwiftApi

protocol MainBussinesModelProtocol {
    func fetch(page: String, completion: @escaping (Result<[MainModel], GithubSwiftError>) -> Void)
}

class MainBusinessModel: MainBussinesModelProtocol {
    private let api: GithubSwiftProtocol
    
    init(api: GithubSwiftProtocol = GithubSwiftApi()) {
        self.api = api
    }
    
    func fetch(page: String, completion: @escaping (Result<[MainModel], GithubSwiftError>) -> Void) {
        api.fetch(page: page) { result in
            switch result {
            case .success(let apiModel):
                let data = MainModelApiParse.get(from: apiModel)
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
