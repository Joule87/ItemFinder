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
    
    init(id: String?, title: String?, price: Int?, currency_id: String?, available_quantity: Int?, thumbnail: String?, condition: String?) {
        self.id = id
        self.title = title
        self.price = price
        self.currency_id = currency_id
        self.available_quantity = available_quantity
        self.thumbnail = thumbnail
        self.condition = condition
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
