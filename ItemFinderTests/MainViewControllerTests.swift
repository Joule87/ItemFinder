//
//  MainViewControllerTests.swift
//  ItemFinderTests
//
//  Created by Julio Collado on 11/19/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import Foundation
import XCTest
@testable import ItemFinder

class MainViewControllerTests: XCTestCase {
    
    var vc: MainViewController?
    
    override func setUp() {
         let storyBoard = UIStoryboard.init(name: Constants.mainStoryBoardName, bundle: nil)
         vc = storyBoard.instantiateViewController(withIdentifier: MainViewController.identifier) as? MainViewController
         let _ = vc?.view
     }

     override func tearDown() {
        vc = nil
     }
    
    func test_PrepareSegue_SetItemFinderPresenter() {
        guard let vc = vc else {
            XCTFail()
            return
        }
        let destinationVC = ItemFinderViewController()
        let segueIdentifier = "SegueItemFinder"
        let segue = UIStoryboardSegue(identifier: segueIdentifier, source: vc, destination: destinationVC)
        vc.prepare(for: segue, sender: vc)
        XCTAssertNotNil(destinationVC.presenter)
    }
}
