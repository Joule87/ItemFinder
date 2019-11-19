//
//  ItemFinderTests.swift
//  ItemFinderTests
//
//  Created by Julio Collado on 11/9/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import Foundation
import XCTest
@testable import ItemFinder

class ItemFinderViewControllerTests: XCTestCase {
    var vc: ItemFinderViewController?
    
    override func setUp() {
        let storyBoard = UIStoryboard.init(name: Constants.mainStoryBoardName, bundle: nil)
        vc = storyBoard.instantiateViewController(withIdentifier: ItemFinderViewController.identifier) as? ItemFinderViewController
        let serviceItemManager = APIItemManagerMock(dataRequest: APIItem())
        let finderPresenter = ItemFinderPresenter(itemAPIService: serviceItemManager)
        finderPresenter.itemFinderViewDelegate = vc
        vc?.presenter = finderPresenter
        let _ = vc?.view
    }

    override func tearDown() {
       vc = nil
    }

    func testInitItemTableView() {
        XCTAssertNotNil(vc?.itemTableView)
    }
    
    func test_LoadView_SetsTableDataSource() {
        XCTAssertTrue(vc?.itemTableView.dataSource is ItemFinderViewController)
    }
    
    func test_LoadView_SetsTableDelegate() {
        XCTAssertTrue(vc?.itemTableView.delegate is ItemFinderViewController)
    }
    
    func test_DataSourceDelegate_SameInstance() {
        XCTAssertEqual(vc?.itemTableView.delegate as? ItemFinderViewController, vc?.itemTableView.dataSource as? ItemFinderViewController)
    }
    
    func test_ItemTableView_withoutItems() {
        XCTAssertEqual(vc?.itemTableView.numberOfRows(inSection: 0), 0)
    }

    func test_NavigationItem_SearchBar() {
        XCTAssertTrue(vc?.navigationItem.titleView is UISearchBar)
    }
    
    func test_SetsTableDelegate() {
        XCTAssertTrue((vc?.navigationItem.titleView as? UISearchBar)?.delegate is ItemFinderViewController)
        
    }
    
    func test_ItemTableView_OneOption() {
        vc?.presenter?.fetchItems(RequestStatusMock.succeed.rawValue, 0)
        XCTAssertEqual(vc?.itemTableView.numberOfRows(inSection: 0), 1)
    }
    
    func test_ItemTableView_OneOption_RenderItemInfo() {
        guard let vc = vc else {
            XCTFail()
            return
        }
        vc.presenter?.fetchItems(RequestStatusMock.succeed.rawValue, 0)
        
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = vc.itemTableView.dataSource?.tableView(vc.itemTableView, cellForRowAt: indexPath) as? ItemTableViewCell
        XCTAssertEqual(cell?.itemNameLabel.text,Constants.MockItem.title)
        XCTAssertEqual(cell?.itemPriceLabel.text, Constants.MockItem.currency_id + " " + "\(Constants.MockItem.price)")
    }
    
    func test_SearchBar_Search() {
        guard let presenter = vc?.presenter else {
            XCTFail()
            return
        }
        var interval: Double = 0
        vc?.debouncer = Debouncer(timeInterval: interval)
        let randomText = RequestStatusMock.succeed.rawValue
        
        guard let searchBar = vc?.navigationItem.titleView as? UISearchBar else {
            XCTFail()
            return
        }
        interval += 2
        searchBar.delegate?.searchBar?(searchBar, textDidChange: randomText)
        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
            XCTAssertEqual(presenter.itemList.count, 1)
        }

    }
    
    func test_SearchBar_CharacterLimitTrue() {
        guard let searchBar = vc?.navigationItem.titleView as? UISearchBar else {
            XCTFail()
            return
        }
        let range = NSRange(location: 0, length: 0)
        let replacement = "b"
        if let isInRange = searchBar.delegate?.searchBar?(searchBar, shouldChangeTextIn: range, replacementText: replacement) {
            XCTAssertTrue(isInRange)
        } else {
            XCTFail()
        }
    }
    
    func test_SearchBar_CharacterLimitFalse() {
         guard let searchBar = vc?.navigationItem.titleView as? UISearchBar else {
             XCTFail()
             return
         }
         let randomtext = "Dfamd fnalksd flms fmklsdm fklmdsk amflkm dksmalkd"
         searchBar.text = randomtext
         let range = NSRange(location: 49, length: 0)
         let replacement = "a"
         if let isInRange = searchBar.delegate?.searchBar?(searchBar, shouldChangeTextIn: range, replacementText: replacement) {
             XCTAssertFalse(isInRange)
         } else {
             XCTFail()
         }
     }
    
    func test_PrepareSegue_SetDetailPresenter() {
        guard let vc = vc else { return }
        let destinationVC = ItemDetailViewController()
        let segueIdentifier = "SegueItemDetail"
        let segue = UIStoryboardSegue(identifier: segueIdentifier, source: vc, destination: destinationVC)
        vc.prepare(for: segue, sender: vc)
        XCTAssertNotNil(destinationVC.presenter)
    }
    
}

