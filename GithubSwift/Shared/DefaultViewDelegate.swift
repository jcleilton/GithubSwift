//
//  DefaultViewDelegate.swift
//  GithubSwift
//
//  Created by Cleilton Feitosa on 15/11/20.
//  Copyright © 2020 Cleilton Feitosa. All rights reserved.
//

import Foundation

protocol DefaultViewDelegate: AnyObject {
    func showLoading()
    func hideLoading()
    func didFinishFetching()
    func didFailFetching(message: String)
    func reloadData()
    func showError(message: String)
}
