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
    
}

class MainBusinessModel: MainBussinesModelProtocol {
    private let api: GithubSwiftProtocol
    
    init(api: GithubSwiftProtocol = GithubSwiftApi()) {
        self.api = api
    }
}
