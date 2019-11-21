//
//  ItemDetailViewControllerTests.swift
//  ItemFinderUITests
//
//  Created by Julio Collado on 11/21/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import XCTest
@testable import ItemFinder

class ItemDetailViewControllerTests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUp() {
        continueAfterFailure = false
        app.launch()
    }
    
    override func tearDown() {
        app.terminate()
    }
    
    func test_UIComponents_Exist() {
        app.buttons[AccessibilityIdentifier.MainViewController.nextButton].tap()
        app.navigationBars["ItemFinder.ItemFinderView"].searchFields["Search Item"].typeText("Casa")
        app.tables.cells.element(boundBy: 0).tap()
        let elementsQuery = app.scrollViews.otherElements
        XCTAssertTrue(elementsQuery.images[AccessibilityIdentifier.ItemDetailViewController.imageView].exists)
        XCTAssertTrue( elementsQuery.buttons[AccessibilityIdentifier.ItemDetailViewController.saveImageButton].exists)
        XCTAssertTrue(elementsQuery.staticTexts[AccessibilityIdentifier.ItemDetailViewController.conditionLabel].exists)
        XCTAssertTrue(elementsQuery.staticTexts[AccessibilityIdentifier.ItemDetailViewController.titleLabel].exists)
        XCTAssertTrue(elementsQuery.staticTexts[AccessibilityIdentifier.ItemDetailViewController.priceLabel].exists)
        XCTAssertTrue(elementsQuery.staticTexts[AccessibilityIdentifier.ItemDetailViewController.stockLabel].exists)
    }
    
}
