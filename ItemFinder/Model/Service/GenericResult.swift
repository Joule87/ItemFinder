//
//  GenericResult.swift
//  ItemFinder
//
//  Created by Julio Collado on 11/9/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import Foundation
import ObjectMapper

struct GenericResult<T: Mappable>: Mappable {

    var site_id: String?
    var query: String?
    var paging: Paging?
    var results: [T]?
    
    init?(map: Map) {
        
    }
    
    init(site_id: String?, query: String?, paging: Paging?, results: [T]?) {
        self.site_id = site_id
        self.query = site_id
        self.paging = paging
        self.results = results
    }
    
    mutating func mapping(map: Map) {
        site_id <- map["site_id"]
        query <- map["query"]
        paging <- map["paging"]
        results <- map["results"]
    }
    
}
