//
//  FinderPresenterUnitTests.swift
//  ItemFinderTests
//
//  Created by Julio Collado on 11/18/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//
import Foundation
import XCTest
@testable import ItemFinder


class FinderPresenterUnitTests: XCTestCase {
    var finderPresenter: ItemFinderPresenterDelegate?
    var finderViewControllerMock: FinderViewControllerMock?
    
    override func setUp() {
        let serviceItemManager = APIItemManagerMock(dataRequest: APIItem())
        finderViewControllerMock = FinderViewControllerMock()
        finderPresenter = ItemFinderPresenter(itemAPIService: serviceItemManager)
        finderPresenter?.itemFinderViewDelegate = finderViewControllerMock
        finderViewControllerMock?.presenter = finderPresenter
    }

    override func tearDown() {
        finderPresenter = nil
        finderViewControllerMock = nil
    }
    
    func test_Failed_FetchItems() {
        finderPresenter?.fetchItems(RequestStatusMock.failed.rawValue, 0)
        if let finderViewController = finderPresenter?.itemFinderViewDelegate as? FinderViewControllerMock {
            XCTAssert(finderViewController.hasRequestSucceed == false)
        } else {
            XCTFail()
        }
    }
    
    func test_Succeed_FetchItems() {
        finderPresenter?.fetchItems(RequestStatusMock.succeed.rawValue, 0)
        if let finderViewController = finderPresenter?.itemFinderViewDelegate as? FinderViewControllerMock {
            XCTAssert(finderViewController.hasRequestSucceed)
        } else {
            XCTFail()
        }
    }
    
    func test_Succeed_ItemsAmount() {
        finderPresenter?.fetchItems(RequestStatusMock.succeed.rawValue, 0)
        XCTAssertEqual(finderPresenter?.itemList.count, 1)
    }
    
    func test_Failed_ItemsAmount() {
        finderPresenter?.fetchItems(RequestStatusMock.failed.rawValue, 0)
        XCTAssertEqual(finderPresenter?.itemList.count, 0)
    }
}
