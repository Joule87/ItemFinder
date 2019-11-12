//
//  ItemDTO.swift
//  ItemFinder
//
//  Created by Julio Collado on 11/9/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import Foundation
import ObjectMapper

struct ItemDTO: Mappable {
    
    var id: String?
    var title: String?
    var price: Int?
    var currency_id: String?
    var available_quantity: Int?
    var thumbnail: String?
    var condition: String?
   
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        price <- map["price"]
        currency_id <- map["currency_id"]
        available_quantity <- map["available_quantity"]
        thumbnail <- map["thumbnail"]
        condition <- map["condition"]
    }
    
    
}
