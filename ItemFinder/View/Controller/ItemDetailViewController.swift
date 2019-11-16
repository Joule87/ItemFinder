//
//  ItemDetailViewController.swift
//  ItemFinder
//
//  Created by Julio Collado on 11/9/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import UIKit

class ItemDetailViewController: BaseViewController {

    //MARK:- Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var stockLabel: UILabel!
    @IBOutlet weak var itemImageView: CustomUIImageView!
    @IBOutlet weak var saveImageButton: UIButton!
    
    //MARK:- Properties
    var presenter: ItemDetailPresenterDelegate?

    //MARK:- View Controller Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUIElements()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveImageButton.setTitle("detail.button.saveImage".localized, for: .normal)
    }
    
    //MARK:- View Controller Functions
    ///Set initial configuration for all UI elements
    func setupUIElements() {
        guard let item = presenter?.item else {
            return
        }
        updateButtonState()
        titleLabel.text = item.title
        conditionLabel.text = item.condition.capitalized
        priceLabel.text = "\(item.currency)" + " " + "\(item.price)"
        stockLabel.text = "detail.label.stock".localized + " \(item.available_quantity)"
        itemImageView.loadImage(fromURL: item.thumbnail) {
            self.updateButtonState()
        }
        
    }
    
    ///Update the state of saveImageButton
    func updateButtonState() {
        let imageExist = self.itemImageView.image != nil
        saveImageButton.isEnabled = imageExist
        saveImageButton.alpha = imageExist ? 1 : 0.4
    }
    
    override func setupNavigationBar() {
        navigationController?.isNavigationBarHidden = false
        navigationController?.hidesBarsOnSwipe = false
    }
    
    //MARK:- Actions

    @IBAction func TappedSaveImageButton(_ sender: UIButton) {
        //TODO:- Save Image in Album Photo
    }
    
    //MARK:- Navigation

}
