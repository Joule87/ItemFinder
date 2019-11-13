//
//  ItemDTOMapper.swift
//  ItemFinder
//
//  Created by Julio Collado on 11/9/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import Foundation

class ItemDTOMapper  {
    
    static func map(_ dto: ItemDTO) -> Item? {
        
        guard let id = dto.id,
            let title = dto.title,
            let price = dto.price,
            let currency = dto.currency_id,
            let available_quantity = dto.available_quantity,
            let thumbnail = dto.thumbnail,
            let condition = dto.condition else {
            return nil
        }
        return Item(id: id,
                    title: title,
                    price: price,
                    currency: currency,
                    available_quantity: available_quantity,
                    thumbnail: thumbnail,
                    condition: condition)
    }
    
    
}
