//
//  Connectable.swift
//  ItemFinder
//
//  Created by Julio Collado on 11/15/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import Foundation

protocol Connectable {
    func isConnectionAvailable() -> Bool
}

extension Connectable {
    func isConnectionAvailable() -> Bool {
        NetworkManager.isConected
    }
}
