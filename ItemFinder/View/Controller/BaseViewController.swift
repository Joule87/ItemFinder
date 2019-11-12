//
//  BaseViewController.swift
//  ItemFinder
//
//  Created by Julio Collado on 11/9/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import UIKit
import KRProgressHUD

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /// Displays a loading view which interrupts any user interaction, usually used for indicating an action is running in the background
    /// - Parameters:
    ///   - isEnable: Flag for turning on or off the loader
    ///   - message: Loader's message.
    func toggleLoading(isEnable: Bool, message: String? = nil) {
        if isEnable {
            KRProgressHUD.show(withMessage: message)
        } else {
            KRProgressHUD.dismiss()
        }
    }
    
    /// Displays an AlertViewController
    /// - Parameters:
    ///   - title: Alert title
    ///   - message: Info message
    ///   - actionTitle: Name of dismiss button
    func warningMessage(title: String, message: String, actionTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .default) { (action) in
            self.dismiss(animated: true)
        }
        alert.addAction(action)
        present(alert, animated: true)
    }

}
