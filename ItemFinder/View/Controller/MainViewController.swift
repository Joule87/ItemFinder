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
    
    //MARK:- Properties

    //MARK:- View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIElements()
    }
    
    //MARK:- View Controller Functions
    ///Set initial configuration for all UI elements
    func setupUIElements() {
        title = "main.title".localized
        nextButton.setTitle("main.next.button".localized, for: .normal)
    }
    
    //MARK:- Actions

    //MARK:- Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //TODO:- Prepare FinderViewController here
    }
    




}

