//
//  ItemFinderViewControllerUITests.swift
//  ItemFinderUITests
//
//  Created by Julio Collado on 11/20/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import UIKit
import XCTest
@testable import ItemFinder

class ItemFinderViewControllerUITests: XCTestCase{
    let app = XCUIApplication()
    override func setUp() {
        continueAfterFailure = false
        app.launch()
    }
    
    override func tearDown() {
        app.terminate()
    }
    
    func test_SearchBar_Exist() {
        let nextbuttonButton = app.buttons[AccessibilityIdentifier.MainViewController.nextButton]
        nextbuttonButton.tap()
        let itemfinderItemfinderviewNavigationBar = app.navigationBars["ItemFinder.ItemFinderView"]
        let searchBar = itemfinderItemfinderviewNavigationBar.searchFields["Search Item"]
        XCTAssertNotNil(searchBar)
    }
    
    func test_BackButton_Exist() {
           let nextbuttonButton = app.buttons[AccessibilityIdentifier.MainViewController.nextButton]
           nextbuttonButton.tap()
           let itemfinderItemfinderviewNavigationBar = app.navigationBars["ItemFinder.ItemFinderView"]
           XCTAssertNotNil(itemfinderItemfinderviewNavigationBar.buttons["Back"].exists)
    }
    
}
