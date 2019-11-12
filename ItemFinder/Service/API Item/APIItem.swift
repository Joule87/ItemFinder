//
//  ItemDataRequest.swift
//  ItemFinder
//
//  Created by Julio Collado on 11/9/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import Foundation
import Alamofire

class APIItem {
    let apiBasePath: String = "https://api.mercadolibre.com/sites/MLA/"
    
    /// Build DataRequest for fetching requested item
    /// - Parameters:
    ///   - query: Text to query
    ///   - offset: Define next range of results
    /// - Returns: Specific type of Request called DataRequest that manages an underlying URLSessionDataTask.
    func fetchItems(query: String, offSet: Int = 0) -> DataRequest {
        let url = "\(self.apiBasePath)search?q=\(query)&offset=\(offSet)"
        return Alamofire.request(url,
                                 method: HTTPMethod.get,
                                 parameters: nil,
                                 encoding: JSONEncoding.default,
                                 headers: nil)
    }
}
