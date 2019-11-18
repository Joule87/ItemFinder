//
//  NetworkManager.swift
//  ItemFinder
//
//  Created by Julio Collado on 11/13/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import Foundation
import Alamofire

///Provide network reachability observer
class NetworkManager {
    
    static let shared = NetworkManager()
    let reachabilityManager = Alamofire.NetworkReachabilityManager(host: Constants.Network.googleURL)
    private(set) static var isConected = false

    
    private init() {
        Logger.info(Constants.Logs.networkManagerStart)
    }
    
    deinit {
        Logger.info(Constants.Logs.networkManagerStop)
    }
    
    ///Start listening for network reachability status changes.
    func startNetworkReachabilityObserver() {
        
        reachabilityManager?.listener = { status in
            switch status {
            case .notReachable:
                NetworkManager.isConected = false
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: Notifications.NetworkNotReachable), object: nil, userInfo: nil)
            case .unknown :
                Logger.warning(status)
                break
            case .reachable(.ethernetOrWiFi):
                NetworkManager.isConected = true
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: Notifications.NetworkReachable), object: nil, userInfo: nil)
            case .reachable(.wwan):
                break
                
            }
        }
        
        reachabilityManager?.startListening()
        Logger.info(Constants.Logs.networkManagerListening)
    }
}
