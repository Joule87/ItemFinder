//
//  APIItemManager.swift
//  ItemFinder
//
//  Created by Julio Collado on 11/9/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import Foundation

class APIItemManager: APIItemService {
    private let itemAPI: APIItem
    
    required init(dataRequest: APIItem) {
        self.itemAPI = dataRequest
    }
    
    func fetchItems(query : String, offset: Int = 0, complete: @escaping (Result<GenericResult<ItemDTO>>) -> ()) {
        let itemDataRequest = itemAPI.fetchItems(query: query, offSet: offset)
        AlamofireRequest.createObjectRequest(request: itemDataRequest) { result in
            complete(result)
        }
    }
}
