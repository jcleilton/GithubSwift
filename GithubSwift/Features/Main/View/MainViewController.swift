//
//  MainViewController.swift
//  GithubSwift
//
//  Created by Cleilton Feitosa on 13/11/20.
//  Copyright © 2020 Cleilton Feitosa. All rights reserved.
//

import UIKit

class MainViewController: DefaultViewController {
    let viewModel: MainViewModel
    
    lazy var tableView: UITableView = {
        let obj = UITableView()
        obj.backgroundColor = .clear
        obj.separatorStyle = .none
        return obj
    }()
    
    lazy var emptyLabel: UILabel = {
        let obj = UILabel()
        obj.font = Constant.font.LABEL
        obj.text = Constant.string.EMPTY_LABEL_TEXT
        obj.textColor = .white
        obj.textAlignment = .center
        return obj
    }()
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.viewModel.fetch()
    }
    
    private func setupView() {
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.emptyLabel)
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.tableView.anchorFillSuperview()
        self.emptyLabel.anchorFillSuperview()
        self.emptyLabel.isHidden = true
        
        self.tableView.register(MainViewTableViewCell.self, forCellReuseIdentifier: MainViewTableViewCell.identifier)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        self.view.frame.width
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MainViewTableViewCell.identifier) as? MainViewTableViewCell, let cellViewModel = self.viewModel.getCellViewModelFrom(indexPath: indexPath) {
            cell.configure(with: cellViewModel)
            return cell
        }
        return UITableViewCell()
    }
}

extension MainViewController: MainViewModelDelegate { }

extension MainViewController: DefaultViewDelegate {
    func showLoading() {
        DispatchQueue.main.async {
            self.showActivity()
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.hideActivity()
        }
    }
    
    func showError(message: String) {
        DispatchQueue.main.async {
            self.showAlert(title: ":(", message: message, confirmActionHandler: nil, completion: nil)
        }
    }
    
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            if (self?.viewModel.count ?? 0) == 0 {
                self?.emptyLabel.isHidden = false
            }
            self?.emptyLabel.isHidden = true
            self?.tableView.reloadData()
        }
    }
    
    func didFinishFetching() {
        self.hideLoading()
        self.reloadData()
    }
    
    func didFailFetching(message: String) {
        self.hideLoading()
        self.showError(message: message)
    }
}
