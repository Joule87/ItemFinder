//
//  ItemFinderUITests.swift
//  ItemFinderUITests
//
//  Created by Julio Collado on 11/20/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import UIKit
import XCTest
@testable import ItemFinder

class MainViewControllerUITests: XCTestCase {
    let app = XCUIApplication()
    override func setUp() {
        continueAfterFailure = false
        app.launch()
    }
    
    override func tearDown() {
        app.terminate()
    }
    
    func test_UIComponents_Exist() {
        XCTAssertTrue(app.staticTexts[AccessibilityIdentifier.MainViewController.welcomeLabel].exists)
        XCTAssertTrue(app.buttons[AccessibilityIdentifier.MainViewController.nextButton].exists)
    }
    
}
