//
//  FinderViewDelegate.swift
//  ItemFinder
//
//  Created by Julio Collado on 11/9/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import Foundation

protocol ItemFinderViewDelegate: AnyObject {
    ///Item request succeed
    func itemRequestSuccessed()
    
    /// Item request failed
    /// - Parameters:
    ///   - error: Request error
    func itemRequestFailed(_ error: Error)

}
