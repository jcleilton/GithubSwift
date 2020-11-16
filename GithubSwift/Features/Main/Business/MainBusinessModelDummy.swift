//
//  MainBusinessModelDummy.swift
//  GithubSwift
//
//  Created by Cleilton Feitosa on 15/11/20.
//  Copyright © 2020 Cleilton Feitosa. All rights reserved.
//

import Foundation
import GithubSwiftApi

class MainBusinessModelDummy: MainBussinesModelProtocol {
    private let api: GithubSwiftProtocol
    
    init(api: GithubSwiftProtocol = GithubSwiftMockApi()) {
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
