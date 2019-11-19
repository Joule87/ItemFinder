//
//  ItemDetailViewControllerTests.swift
//  ItemFinderTests
//
//  Created by Julio Collado on 11/18/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import Foundation
import XCTest
@testable import ItemFinder

class ItemDetailViewControllerTests: XCTestCase {
    var vc: ItemDetailViewController?

    override func setUp() {
        let storyBoard = UIStoryboard.init(name: Constants.mainStoryBoardName, bundle: nil)
        vc = storyBoard.instantiateViewController(withIdentifier: ItemDetailViewController.identifier) as? ItemDetailViewController
        let itemDetailPresenter = ItemDetailPresenter()
        itemDetailPresenter.item = getMockItem()
        vc?.presenter = itemDetailPresenter
        let _ = vc?.view
    }

    override func tearDown() {
       vc = nil
    }
    
    func test_viewWillAppear_RenderItemInfo() {
        vc?.viewWillAppear(true)
        XCTAssertEqual(vc?.titleLabel.text, Constants.MockItem.title)
        XCTAssertEqual(vc?.priceLabel.text, Constants.MockItem.currency_id + " " + "\(Constants.MockItem.price)")
    }
}

extension ItemDetailViewControllerTests {
    func getMockItem() -> Item {
        return Item(id: Constants.MockItem.id,
        title: Constants.MockItem.title,
        price: Constants.MockItem.price,
        currency: Constants.MockItem.currency_id,
        available_quantity: Constants.MockItem.available_quantity,
        thumbnail: Constants.MockItem.thumbnail,
        condition: Constants.MockItem.condition)
    }
}
