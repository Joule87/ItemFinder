//
//  ItemFinderPresenter.swift
//  ItemFinder
//
//  Created by Julio Collado on 11/9/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import Foundation

class ItemFinderPresenter: ItemFinderPresenterDelegate {
    weak var itemFinderViewDelegate: ItemFinderViewDelegate?
    var itemList: [Item?] = []
    var itemAPIService: APIItemService
    
    required init(itemAPIService: APIItemService) {
        self.itemAPIService = itemAPIService
    }
    
    func fetchItems(_ query: String, _ offset: Int) {
        itemAPIService.fetchItems(query: query, offset: offset) { result in
            //TODO:- Handle result
        }
    }
    
    
}
