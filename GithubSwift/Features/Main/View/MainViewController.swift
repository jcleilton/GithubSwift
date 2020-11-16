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
    
    lazy var headerView: MainViewHeader = {
        let obj = MainViewHeader()
        return obj
    }()
    
    lazy var tableView: UITableView = {
        let obj = UITableView()
        obj.backgroundColor = Constant.color.clean
        obj.separatorStyle = .none
        return obj
    }()
    
    lazy var emptyLabel: UILabel = {
        let obj = UILabel()
        obj.font = Constant.font.label
        obj.text = Constant.string.emptyLabelText
        obj.textColor = .white
        obj.textAlignment = .center
        return obj
    }()
    
    lazy var refreshControle: UIRefreshControl = { [weak self] in
        guard let self = self else { return UIRefreshControl() }
        let obj = UIRefreshControl()
        obj.addTarget(self, action: #selector(self.refreshData), for: .valueChanged)
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
    
    @objc func refreshData() {
        self.viewModel.refreshData()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        let bounds = scrollView.bounds
        let size = scrollView.contentSize
        let inset = scrollView.contentInset
        let y = offset.y + bounds.size.height - inset.bottom
        let h = size.height
        let reload_distance: CGFloat = 10.0
        
        if (y > (h + reload_distance)) {
            if self.refreshControle.isRefreshing {
                return
            }
            viewModel.fetch()
        }
    }
    

    
    private func setupView() {
        self.view.addSubview(self.headerView)
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.emptyLabel)
        
        self.headerView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.headerView.anchor(
            top: (anchor: self.view.topAnchor, constant: Constant.distance.zero),
            left: (anchor: self.view.leftAnchor, constant: Constant.distance.zero),
            right: (anchor: self.view.rightAnchor, constant: Constant.distance.zero),
            relativeHeight: (anchor: self.view.heightAnchor, multiplier: 0.12, constant: Constant.distance.zero))
        
        self.tableView.anchor(
            top: (anchor: self.headerView.bottomAnchor, constant: Constant.distance.zero),
            bottom: (anchor: self.view.bottomAnchor, constant: Constant.distance.zero),
            left: (anchor: self.view.leftAnchor, constant: Constant.distance.zero),
            right: (anchor: self.view.rightAnchor, constant: Constant.distance.zero))
        
        self.emptyLabel.anchorFillSuperview()
        self.emptyLabel.isHidden = true
        
        self.tableView.register(MainViewTableViewCell.self, forCellReuseIdentifier: MainViewTableViewCell.identifier)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.addSubview(self.refreshControle)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let detailViewModel = viewModel.getDetailViewModel(from: indexPath) {
            let detailViewController = DetailViewController(viewModel: detailViewModel)
            self.present(detailViewController, animated: true, completion: nil)
        } else {
            self.showError(message: Constant.string.errorDetailPresent)
        }
    }
}

extension MainViewController: MainViewModelDelegate { }

extension MainViewController: DefaultViewDelegate {
    func showLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.showActivity()
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.hideActivity()
            self?.refreshControle.endRefreshing()
        }
    }
    
    func showError(message: String) {
        DispatchQueue.main.async { [weak self] in
            self?.showAlert(title: ":(", message: message, confirmActionHandler: nil, completion: nil)
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
