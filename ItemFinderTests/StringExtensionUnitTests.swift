//
//  File.swift
//  ItemFinderTests
//
//  Created by Julio Collado on 11/21/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import Foundation
import XCTest
@testable import ItemFinder

class StringExtensionUnitTests: XCTestCase {
    
    func test_check_HTML_Entities() {
        let ampersand = "&"
        let ampersandHTMLentity = "&amp;"
        XCTAssertEqual(ampersandHTMLentity.decodingHTMLEntities(), ampersand)
        
        let apostrophe = "'"
        let apostropheHTMLentity = "&apos;"
        XCTAssertEqual(apostropheHTMLentity.decodingHTMLEntities(), apostrophe)
        
        let less_than = "<"
        let less_thanHTMLentity = "&lt;"
        XCTAssertEqual(less_thanHTMLentity.decodingHTMLEntities(), less_than)
        
        let grearter_than = ">"
        let grearter_thanHTMLentity = "&gt;"
        XCTAssertEqual(grearter_thanHTMLentity.decodingHTMLEntities(), grearter_than)
        XCTAssertNotEqual(grearter_thanHTMLentity.decodingHTMLEntities(), less_than)
        
        let euro = "€"
        let euro_HTMLentity = "&#x20ac;"
        XCTAssertEqual(euro_HTMLentity.decodingHTMLEntities(), euro)
        
        let arroba = "@"
        let arroba_HTMLentity = "&#64;"
        XCTAssertEqual(arroba_HTMLentity.decodingHTMLEntities(), arroba)
        
        let eCharacter = "e"
        XCTAssertEqual(eCharacter.decodingHTMLEntities(), eCharacter)
    }
}
