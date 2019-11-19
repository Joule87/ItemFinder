//
//  CustomUIImageViewTests.swift
//  ItemFinderTests
//
//  Created by Julio Collado on 11/19/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import UIKit
import XCTest
@testable import ItemFinder

class CustomUIImageViewTests: XCTestCase {
 
    func test_CustomUIImageView_FetchingImage_ValidURL() {
        let customUIImageView = CustomUIImageView()
        let expectation = XCTestExpectation(description: "Fetching Image from valid URL")
        customUIImageView.loadImage(fromURL: Constants.MockItem.thumbnail) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
        
    }
    
    func test_CustomUIImageView_FetchingImage_InvalidURL() {
        let customUIImageView = CustomUIImageView()
        let expectation = XCTestExpectation(description: "Fetching Image from invalid URL")
        let invalidURL = "http://www.mla-invalid-url.com/801300-MLA32859281461_11201923-I.jpg"
        customUIImageView.loadImage(fromURL: invalidURL) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
        
    }
}
