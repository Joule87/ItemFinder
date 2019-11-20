//
//  BaseViewController.swift
//  ItemFinder
//
//  Created by Julio Collado on 11/9/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import UIKit
import KRProgressHUD

class BaseViewController: UIViewController, Connectable {
    
    private var removeNotificationsOnDissapear = false
    
    private lazy var notConnectionView: UIView = {
        let alpha: CGFloat = 0.8
        let viewColor: UIColor = UIColor.lightGray
        let emptyView = UIView()
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        emptyView.backgroundColor = viewColor.withAlphaComponent(alpha)
        
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "alert.notInternetConection".localized
        
        let stack = UIStackView(arrangedSubviews: [label])
        stack.distribution = .fill
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.contentMode = .scaleAspectFit
        
        emptyView.addSubview(stack)
        
        [stack.leadingAnchor.constraint(equalTo: emptyView.leadingAnchor),
         stack.trailingAnchor.constraint(equalTo: emptyView.trailingAnchor),
         stack.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
         stack.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor)].forEach{$0.isActive = true}
        
        return emptyView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerForNotificationsOnAppearAndDisappear()
        updateUIConnectionStatus()
        setupNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if removeNotificationsOnDissapear {
            NotificationCenter.default.removeObserver(self)
        }
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

    ///Setup  initial navigation bar state
    func setupNavigationBar() {
     
    }
    
}

extension BaseViewController {
    func registerForNotificationsOnAppearAndDisappear() {
        removeNotificationsOnDissapear = true
        NotificationCenter.default.addObserver(self, selector: #selector(didLostConnection(notification:)),
                                               name: NSNotification.Name.init(Notifications.NetworkNotReachable), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didGetConnection(notification:)),
                                               name: NSNotification.Name.init(Notifications.NetworkReachable), object: nil)
    }
    
    ///Adds notConnectionView at the bottom of the view warning user about the loss of internet connection
    func showNotConnectionWarningView() {
        DispatchQueue.main.async {
            self.view.addSubview(self.notConnectionView)
            [self.notConnectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
             self.notConnectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
             self.notConnectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0),
             self.notConnectionView.heightAnchor.constraint(equalToConstant: 70)].forEach{$0.isActive = true}
        }
    }
    
    ///Remove notConnectionView from View parent
    func removeNotConnectionWarningView() {
        DispatchQueue.main.async {
            self.notConnectionView.removeFromSuperview()
        }
    }
    
    ///Is triggered when the device lost connection and shows a View alerting about it
    @objc func didLostConnection(notification: Notification) {
        if !isConnectionAvailable() {
            showNotConnectionWarningView()
        }
        
    }
    
    ///Is triggered when the device got connection and remove the alerting view
    @objc func didGetConnection(notification: Notification) {
        if isConnectionAvailable() {
            removeNotConnectionWarningView()
        }
        
    }
    
    ///Update connection status on every view
    func updateUIConnectionStatus() {
        if isConnectionAvailable() {
            removeNotConnectionWarningView()
        } else {
            showNotConnectionWarningView()
        }
    }
}
