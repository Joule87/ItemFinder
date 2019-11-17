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
    
    ///Save Image in Photo Album directory
    func saveImage() {
        DispatchQueue.main.async {
            guard let image = self.itemImageView.image else {
                return
            }
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            self.warningMessage(title: "alert.success".localized, message: "alert.success.imageSaved".localized, actionTitle: "alert.action.ok".localized)
        }
        
    }
  
    
    ///Show an alert warning the user that access to Photo Album is denied and permissions must be granted from device Settings
    func warnAccessDenied() {
        DispatchQueue.main.async {
            let deniedAlert = UIAlertController(title: "alert.title.photoLibraryDenied".localized, message: "alert.message.photoLibraryDenied".localized, preferredStyle: .alert)
            let goToSettingsAction = UIAlertAction(title: "alert.button.goToSettings".localized, style: .default) { action in
                guard let url = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:])
                }
            }
            let cancelAction =  UIAlertAction(title: "alert.action.cancel".localized, style: .cancel)
            deniedAlert.addAction(goToSettingsAction)
            deniedAlert.addAction(cancelAction)
            self.present(deniedAlert, animated: true)
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
                self.warningMessage(title: "alert.title.photoLibraryRestricted".localized, message: "alert.message.photoLibraryRestricted".localized, actionTitle: "alert.action.ok".localized)
            case .denied:
                self.warnAccessDenied()
            case .authorized:
                self.saveImage()
            @unknown default:
                ///Log status
                break
            }
        }
    }
    
    //MARK:- Navigation

}
