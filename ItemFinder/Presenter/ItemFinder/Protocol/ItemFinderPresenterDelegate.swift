//
//  ItemFinderPresenterDelegate.swift
//  ItemFinder
//
//  Created by Julio Collado on 11/9/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import Foundation

protocol ItemFinderPresenterDelegate {
    var itemFinderViewDelegate: ItemFinderViewDelegate? { set get }
    var itemList: [Item?] { get }
    var itemAPIService: APIItemService { get }

    init (itemAPIService: APIItemService)
    
    func fetchItems(_ query: String, _ offset: Int)
}
