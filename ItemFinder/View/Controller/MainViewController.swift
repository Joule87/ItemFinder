//
//  ViewController.swift
//  ItemFinder
//
//  Created by Julio Collado on 11/9/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController {

    //MARK:- Outlets
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    //MARK:- Properties
    static let identifier = "MainViewController"

    //MARK:- View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIElements()
    }
    
    //MARK:- View Controller Functions
    ///Set initial configuration for all UI elements
    func setupUIElements() {
        welcomeLabel.text = "main.welcome.label".localized
        welcomeLabel.accessibilityIdentifier = AccessibilityIdentifier.MainViewController.welcomeLabel
        nextButton.setTitle("main.next.button".localized, for: .normal)
        nextButton.accessibilityIdentifier = AccessibilityIdentifier.MainViewController.nextButton
    }
    
    override func setupNavigationBar() {
        navigationController?.isNavigationBarHidden = true
        navigationController?.hidesBarsOnSwipe = false
    }
    
    //MARK:- Actions

    //MARK:- Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let itemFinderViewController = segue.destination as? ItemFinderViewController {
            let itemAPI = APIItem()
            let serviceItemManager = APIItemManager(dataRequest: itemAPI)
            let itemFinderPresenter = ItemFinderPresenter(itemAPIService: serviceItemManager)
            itemFinderPresenter.itemFinderViewDelegate = itemFinderViewController
            itemFinderViewController.presenter = itemFinderPresenter
            itemFinderViewController.debouncer = Debouncer(timeInterval: 0.5)
        }
    }
    




}

