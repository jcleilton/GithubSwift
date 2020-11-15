//
//  AppDelegate.swift
//  GithubSwift
//
//  Created by Cleilton Feitosa on 13/11/20.
//  Copyright © 2020 Cleilton Feitosa. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = self.window ?? UIWindow()
        let viewModel = MainViewModel()
        let controller = MainViewController(viewModel: viewModel)
        self.window?.rootViewController = controller
        self.window?.makeKeyAndVisible()
        return true
    }
}
