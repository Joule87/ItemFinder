//
//  AccessibilityIdentifier.swift
//  ItemFinder
//
//  Created by Julio Collado on 11/20/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import Foundation

struct AccessibilityIdentifier {
    struct MainViewController {
        static let welcomeLabel = "welcomeLabel"
        static let nextButton = "nextButton"
    }
    
    struct ItemFinderViewController {
        static let searchbar = "searchbar"
        static let nextButton = "nextButton"
    }
    
    struct ItemDetailViewController {
        static let imageView = "imageView"
        static let saveImageButton = "saveImageButton"
        static let conditionLabel = "conditionLabel"
        static let titleLabel = "titleLabel"
        static let priceLabel = "priceLabel"
        static let stockLabel = "stockLabel"
    }
}
