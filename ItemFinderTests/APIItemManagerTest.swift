//
//  APIItemManagerTest.swift
//  ItemFinderTests
//
//  Created by Julio Collado on 11/19/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import Foundation
import XCTest
@testable import ItemFinder

class APIItemManagerTest: XCTestCase {
    var apiItemManager: APIItemManager?
    
    override func setUp() {
        let apiItem = APIItem()
        apiItemManager = APIItemManager(dataRequest: apiItem)
    }
    
    override func tearDown() {
        apiItemManager = nil
    }
    
    func test_APIResponse() {
        let randomText = "Casa"
        let expectation = XCTestExpectation(description: "Fetching Items")
        apiItemManager?.fetchItems(query: randomText, completion: { result in
            XCTAssertNotNil(result)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 5)
    }
}
