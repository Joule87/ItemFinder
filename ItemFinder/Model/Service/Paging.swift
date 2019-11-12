//
//  Paging.swift
//  ItemFinder
//
//  Created by Julio Collado on 11/9/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import Foundation
import ObjectMapper

struct Paging: Mappable {
    
    var total: Int?
    var offset: Int?
    var limit: Int?
    var primary_results: Int?
    
    mutating func mapping(map: Map) {
        total <- map["total"]
        offset <- map["offset"]
        limit <- map["limit"]
        primary_results <- map["offset"]
    }
    
    init?(map: Map) {
        
    }

}
