//
//  UIViewExtensionTests.swift
//  ItemFinderTests
//
//  Created by Julio Collado on 11/19/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import UIKit
import XCTest
@testable import ItemFinder

class UIViewExtensionTests: XCTestCase {

    func test_UIView_BorderConfiguration() {
        let customView =  UIView()
        customView.borderWidth = 2
        customView.borderColor = UIColor.white
        XCTAssertEqual(customView.borderWidth, 2)
        XCTAssertEqual(customView.borderColor, UIColor.white)
        
        customView.borderColor = nil
        XCTAssertNil(customView.borderColor)
    }
    
    func test_UIView_shadowConfiguration() {
        let customView =  UIView()
        let shadowOffSet = CGSize(width: 1, height: 1)
        customView.shadowColor = UIColor.black
        customView.shadowOffset = shadowOffSet
        customView.shadowRadius = 2
        customView.shadowOpacity = 0.7
        
        XCTAssertEqual(customView.shadowColor, UIColor.black)
        XCTAssertEqual(customView.shadowOffset, shadowOffSet)
        XCTAssertEqual(customView.shadowRadius, 2)
        XCTAssertEqual(customView.shadowOpacity, 0.7)
    }
    
    func test_UIView_CornerRadiusConfiguration() {
        let cornerRadius = CGFloat(1)
        let customView =  UIView()
        customView.cornerRadius = cornerRadius
         XCTAssertEqual(customView.cornerRadius, cornerRadius)
    }
}
