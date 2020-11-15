//
//  MainViewModel.swift
//  GithubSwift
//
//  Created by Cleilton Feitosa on 13/11/20.
//  Copyright © 2020 Cleilton Feitosa. All rights reserved.
//

import Foundation

protocol MainViewModelDelegate: AnyObject {
    
}

class MainViewModel {
    weak var delegate: (MainViewModelDelegate & DefaultViewDelegate)?
    private let businessModel: MainBussinesModelProtocol
    
    init(businessModel: MainBussinesModelProtocol = MainBusinessModel()) {
        self.businessModel = businessModel
    }
}
