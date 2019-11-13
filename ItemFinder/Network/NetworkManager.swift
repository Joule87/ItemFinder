//
//  NetworkManager.swift
//  ItemFinder
//
//  Created by Julio Collado on 11/13/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.google.com")
    private init() {}
    
    ///Start listening for network reachability status changes.
    func startNetworkReachabilityObserver() {
        
        reachabilityManager?.listener = { status in
            switch status {
            case .notReachable:
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: Notifications.NetworkNotReachable), object: nil, userInfo: nil)
            case .unknown :
                break
            case .reachable(.ethernetOrWiFi):
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: Notifications.NetworkReachable), object: nil, userInfo: nil)
            case .reachable(.wwan):
                break
                
            }
        }
        
        reachabilityManager?.startListening()
        
    }
}
