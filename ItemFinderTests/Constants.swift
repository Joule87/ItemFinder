//
//  Constants.swift
//  ItemFinderTests
//
//  Created by Julio Collado on 11/18/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import Foundation

internal struct Constants {
    
    static let mainStoryBoardName = "Main"
    
    struct MockItem {
        static let id = "mockID"
        static let title = "mockTitle"
        static let price = 150
        static let currency_id = "USD"
        static let available_quantity = 2
        static let thumbnail = "http://mla-s1-p.mlstatic.com/801300-MLA32859281461_112019-I.jpg"
        static let condition = "New"
    }
    
    struct MockGenericResult {
        static let id = "resultMockId"
        static let query = "ResultMockQuery"
    }
    
    struct MockPaging {
        static let total = 1000
        static let offset = 50
        static let limit = 200
        static let primary_results = 50
    }
}
