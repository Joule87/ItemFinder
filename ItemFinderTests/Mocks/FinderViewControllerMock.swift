//
//  FinderViewControllerMock.swift
//  ItemFinderTests
//
//  Created by Julio Collado on 11/18/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import UIKit
@testable import ItemFinder

class FinderViewControllerMock {
    var presenter: ItemFinderPresenterDelegate?
    var hasRequestSucceed: Bool = false
}

extension FinderViewControllerMock: ItemFinderViewDelegate {
    func itemRequestSuccessed() {
        hasRequestSucceed = true
    }
    
    func itemRequestFailed(_ error: Error) {
        hasRequestSucceed = false
    }
    
    
}
