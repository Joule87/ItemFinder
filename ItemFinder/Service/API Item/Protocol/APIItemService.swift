//
//  APIItemService.swift
//  ItemFinder
//
//  Created by Julio Collado on 11/9/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import Foundation

protocol APIItemService {
    /// Request items that match to the given text
    /// - Parameters:
    ///   - query: Text to query
    ///   - offset: Define next range of results
    ///   - complete: Action to take
    func fetchItems(query : String, offset: Int, completion: @escaping (Result<GenericResult<ItemDTO>>) -> ())
}
