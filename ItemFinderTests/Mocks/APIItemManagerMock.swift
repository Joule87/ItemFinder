//
//  APIItemManagerMock.swift
//  ItemFinderTests
//
//  Created by Julio Collado on 11/18/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import Foundation
@testable import ItemFinder

class APIItemManagerMock: APIItemService {
    
    required init(dataRequest: APIItem) {
    }
    
    func fetchItems(query: String, offset: Int, completion complete: @escaping (Result<GenericResult<ItemDTO>>) -> ()) {
        switch query {
        case RequestStatusMock.succeed.rawValue:
            if let value = getMockResultItem() {
                complete(value)
            }
        case RequestStatusMock.failed.rawValue:
            complete(.failure(error: NSError(), data: nil))
        default:
            break
        }
    }
    
    func getMockResultItem() -> Result<GenericResult<ItemDTO>>? {
        let paging = Paging(total: Constants.MockPaging.total,
                            offset: Constants.MockPaging.offset,
                            limit: Constants.MockPaging.limit,
                            primary_results: Constants.MockPaging.primary_results)
        let itemDTO = ItemDTO(id: Constants.MockItem.id,
                              title: Constants.MockItem.title,
                              price: Constants.MockItem.price,
                              currency_id: Constants.MockItem.currency_id,
                              available_quantity: Constants.MockItem.available_quantity,
                              thumbnail: Constants.MockItem.thumbnail,
                              condition: Constants.MockItem.condition)
        let value = GenericResult<ItemDTO>(site_id: Constants.MockGenericResult.id,
                                           query: Constants.MockGenericResult.query,
                                           paging: paging, results: [itemDTO])
        
        return Result.success(value)
    }
    
}
