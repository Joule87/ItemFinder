//
//  ItemDetailViewController.swift
//  ItemFinder
//
//  Created by Julio Collado on 11/9/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import UIKit
import Photos

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
    static let identifier = "ItemDetailViewController"

    //MARK:- View Controller Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUIElements()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUIElementsAccessibility()
        saveImageButton.setTitle("detail.button.saveImage".localized, for: .normal)
    }
    
    //MARK:- View Controller Functions
    ///Update UI elements configuration
    func updateUIElements() {
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
    
    ///Set accessibility identifier to every ui element
    func setUIElementsAccessibility() {
        itemImageView.accessibilityIdentifier = AccessibilityIdentifier.ItemDetailViewController.imageView
        saveImageButton.accessibilityIdentifier = AccessibilityIdentifier.ItemDetailViewController.saveImageButton
        conditionLabel.accessibilityIdentifier = AccessibilityIdentifier.ItemDetailViewController.conditionLabel
        titleLabel.accessibilityIdentifier = AccessibilityIdentifier.ItemDetailViewController.titleLabel
        priceLabel.accessibilityIdentifier = AccessibilityIdentifier.ItemDetailViewController.priceLabel
        stockLabel.accessibilityIdentifier = AccessibilityIdentifier.ItemDetailViewController.stockLabel
    }
    
    ///Update the state of saveImageButton
    func updateButtonState() {
        let imageExist = self.itemImageView.image != nil
        saveImageButton.isEnabled = imageExist
        saveImageButton.alpha = imageExist ? 1 : 0.4
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        navigationController?.isNavigationBarHidden = false
        navigationController?.hidesBarsOnSwipe = false
    }
    
    ///Save Image in Photo Album directory
    func saveImage() {
        DispatchQueue.main.async {
            guard let image = self.itemImageView.image else {
                return
            }
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            AlertHelper.showBasicAlert(on: self, with: "alert.success".localized, message: "alert.success.imageSaved".localized, actionTitle: "alert.action.ok".localized)
        }
        
    }
  
    
    ///Show an alert warning the user that access to Photo Album is denied and permissions must be granted from device Settings
    func warnAccessDenied() {
        AlertHelper.showTwoOptionAlert(on: self, with: "alert.title.photoLibraryDenied".localized, message: "alert.message.photoLibraryDenied".localized, firstActionTitle: "alert.action.cancel".localized, secondActionTitle: "alert.button.goToSettings".localized) {
            guard let url = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:])
            }
        }
    }
    
    //MARK:- Actions

    @IBAction func TappedSaveImageButton(_ sender: UIButton) {
        PHPhotoLibrary.requestAuthorization() { (status) -> Void in
            switch status {
            case .notDetermined:
                if status == PHAuthorizationStatus.authorized {
                    self.saveImage()
                }
            case .restricted:
                AlertHelper.showBasicAlert(on: self, with:  "alert.title.photoLibraryRestricted".localized, message: "alert.message.photoLibraryRestricted".localized, actionTitle: "alert.action.ok".localized)
            case .denied:
                self.warnAccessDenied()
            case .authorized:
                self.saveImage()
            @unknown default:
                Logger.warning(status)
                break
            }
        }
    }
    
    //MARK:- Navigation

}
