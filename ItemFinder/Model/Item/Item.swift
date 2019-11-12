//
//  Item.swift
//  ItemFinder
//
//  Created by Julio Collado on 11/9/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import Foundation

class Item {
    
    var id: String?
    var title: String?
    var price: Int?
    var currency: String?
    var available_quantity: Int?
    var thumbnail: String?
    var condition: String?
    
    init(id: String, title: String, price: Int, currency: String, available_quantity: Int, thumbnail: String, condition: String) {
        self.id = id
        self.title = title
        self.price = price
        self.currency = currency
        self.available_quantity = available_quantity
        self.thumbnail = thumbnail
        self.condition = condition
    }
    
}
