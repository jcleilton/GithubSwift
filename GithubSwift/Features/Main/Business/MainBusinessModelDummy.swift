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
}
