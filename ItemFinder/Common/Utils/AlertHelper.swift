//
//  AlertHelper.swift
//  ItemFinder
//
//  Created by Julio Collado on 11/20/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import UIKit

struct AlertHelper {
    
    typealias Action = () -> Void
    
    /// Displays an Alert on given ViewController
    /// - Parameters:
    ///   - viewController: ViewController presenting the alert
    ///   - title: Alert title
    ///   - message: Info message
    ///   - actionTitle: Name of the action
    static func showBasicAlert(on viewController: UIViewController, with title: String, message: String, actionTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .default, handler: nil)
        alert.addAction(action)
        DispatchQueue.main.async {
            viewController.present(alert, animated: true)
        }
    }
    
    /// Displays an Alert on given ViewController with two option
    /// - Parameters:
    ///   - viewController: ViewController presenting the alert
    ///   - title: Alert title
    ///   - message: Info message
    ///   - firstActionTitle: Name of the left action
    ///   - secondActionTitle: Name of the right action
    ///   - secondAction: Executable block of code  to run in the second action
    static func showTwoOptionAlert(on viewController: UIViewController, with title: String, message: String, firstActionTitle: String, secondActionTitle: String,  secondAction: @escaping Action) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let rightAction = UIAlertAction(title: secondActionTitle, style: .default) { _ in
                secondAction()
            }
            let leftAction =  UIAlertAction(title: firstActionTitle, style: .cancel)
            alert.addAction(rightAction)
            alert.addAction(leftAction)
            viewController.present(alert, animated: true)
        }
        
    }
    
}

