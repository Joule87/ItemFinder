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
    private var lastQuery: String?
    
    required init(itemAPIService: APIItemService) {
        self.itemAPIService = itemAPIService
    }
    
    func fetchItems(_ query: String, _ offset: Int) {
        resetItemList(for: query)
        itemAPIService.fetchItems(query: query, offset: offset) { [weak self] result in
            guard let saveSelf = self else { return }
            switch result {
            case .success(let value):
                saveSelf.processResult(value)
                saveSelf.itemFinderViewDelegate?.itemRequestSuccessed()
                break
            case .failure(let error, _):
                saveSelf.itemFinderViewDelegate?.itemRequestFailed(error)
                break
            }
            
        }
    }
    
    /// Remove all the items for last search is current query is new
    /// - Parameters:
    ///   - newQuery: element user wants to search
    private func resetItemList(for newQuery: String) {
        if let lastQuery = lastQuery, lastQuery != newQuery {
            itemList.removeAll()
        }
        self.lastQuery = newQuery
    }
    
    ///Process fetched items.
    /// - Parameters:
    ///   - value: Request response
    private func processResult(_ value: GenericResult<ItemDTO>) {
        guard let itemsDTO = value.results, !itemsDTO.isEmpty else {
            return
        }
        let resultItemList = itemsDTO.map{ ItemDTOMapper.map($0) }
        itemList.append(contentsOf: resultItemList)
    }
    
    
}
