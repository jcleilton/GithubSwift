//
//  DefaultViewController.swift
//  GithubSwift
//
//  Created by Cleilton Feitosa on 15/11/20.
//  Copyright © 2020 Cleilton Feitosa. All rights reserved.
//

import UIKit

class DefaultViewController: UIViewController {
    fileprivate var activityController: UIView? = nil
    fileprivate let labelActivity: UILabel = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 200.0, height: 30.0))
    fileprivate var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    fileprivate var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            self.overrideUserInterfaceStyle = .light
        }
        self.view.backgroundColor = Constant.color.MAIN
    }
    
    func setupNavigation(_ title: String? = nil) {
        self.navigationItem.title = title ?? Constant.string.APP_NAME
    }
    
    fileprivate func showActivity(){
        if activityController == nil {
            activityController = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
            activityController?.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.6)
            let activity = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
            activity.center = (activityController?.center)!
            activity.startAnimating()
            
            labelActivity.frame.size.width = (activityController?.bounds.width ?? 0.0) * 0.9
            labelActivity.center = (activityController?.center)!
            labelActivity.frame.origin.x = ((activityController?.bounds.width ?? 0.0) - labelActivity.bounds.width)/2
            labelActivity.frame.origin.y = activity.frame.origin.y + activity.bounds.height + 8
            labelActivity.text = Constant.string.LOADING_TEXT
            labelActivity.textAlignment = .center
            labelActivity.textColor = UIColor.white
            
            activityController?.addSubview(labelActivity)
            activityController?.addSubview(activity)
        }
        guard let navigationController = self.navigationController else {
            self.view.addSubview(self.activityController!)
            return
        }
        navigationController.view.addSubview(activityController!)
    }
    
    fileprivate func hideActivity(){
        activityController?.removeFromSuperview()
    }
    
    func showAlert(title: String?, message: String?, confirmActionHandler: ((_ action: UIAlertAction) -> Void)?, completion: (() -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: Constant.string.OK, style: .default, handler: confirmActionHandler)
        alert.addAction(confirmAction)
        DispatchQueue.main.async{ [weak self] in
            self?.present(alert, animated: true, completion: completion)
        }
    }
}

extension DefaultViewController: DefaultViewDelegate {
    func showLoading() {
        self.showActivity()
    }
    
    func hideLoading() {
        self.hideActivity()
    }
    
    func reloadData() { }
    
    func showError(message: String) {
        self.showAlert(title: ":(", message: message, confirmActionHandler: nil, completion: nil)
    }
}
