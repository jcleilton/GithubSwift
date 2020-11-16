//
//  MainViewModel.swift
//  GithubSwift
//
//  Created by Cleilton Feitosa on 13/11/20.
//  Copyright © 2020 Cleilton Feitosa. All rights reserved.
//

import Foundation

protocol MainViewModelDelegate: AnyObject { /** TODO: Algo específico desta viewModel */ }

class MainViewModel {
    weak var delegate: (MainViewModelDelegate & DefaultViewDelegate)?
    private let businessModel: MainBussinesModelProtocol
    private var cellViewModels: [MainViewTableViewCellViewModel] = []
    private var currentPage: Int = 0
    private var hasData: Bool = true
    var count: Int {
        self.cellViewModels.count
    }
    private var isLoading: Bool = false
    
    init(businessModel: MainBussinesModelProtocol = MainBusinessModel()) {
        self.businessModel = businessModel
    }
    
    func getCellViewModelFrom(indexPath: IndexPath) -> MainViewTableViewCellViewModel? {
        if indexPath.row < self.cellViewModels.count {
            return self.cellViewModels[indexPath.row]
        }
        return nil
    }
    
    func fetch() {
        if self.isLoading {
            return
        }
        self.isLoading = true
        self.delegate?.showLoading()
        if self.hasData {
            self.currentPage += 1
            self.businessModel.fetch(page: "\(self.currentPage)") { [weak self] result in
                switch result {
                case .success(let data):
                    self?.cellViewModels += data.compactMap{ MainViewTableViewCellViewModel(model: $0) }
                    self?.delegate?.didFinishFetching()
                case .failure(let error):
                    switch error {
                    case .noMorePages:
                        self?.delegate?.didFinishFetching()
                        self?.hasData = false
                    default:
                        let message = MainModelApiParse.getMessage(from: error)
                        self?.delegate?.didFailFetching(message: message)
                    }
                }
                self?.isLoading = false
            }
        } else {
            self.delegate?.hideLoading()
        }
    }
    
    func refreshData() {
        self.currentPage = 0
        self.hasData = true
        self.cellViewModels = []
        self.isLoading = false
        self.fetch()
    }
}
