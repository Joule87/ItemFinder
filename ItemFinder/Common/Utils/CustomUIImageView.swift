//
//  CustomUIImageView.swift
//  ItemFinder
//
//  Created by Julio Collado on 11/12/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import UIKit

class CustomUIImageView: UIImageView {
    
    var imageUrlString: String?
    static let imageCache = NSCache<NSString, AnyObject>()
    
    /// Fetch image from given URL String
    /// - Parameters:
    ///   - url: Image URL
    func loadImage(fromURL url: String) {
        self.image = nil
        imageUrlString = url
        
        if let imageFromCache = CustomUIImageView.imageCache.object(forKey: NSString(string: url)) as? UIImage {
            transition(toImage: imageFromCache)
            return
        }
        
        guard let imageURL = URL(string: url) else {
            return
        }
        
        APIImageManager.requestImage(for: imageURL) { [weak self] data in
            guard let saveSelf = self else { return }
            saveSelf.processImageData(data, for: url)
        }
        
    }
    
    /// Place your Summary  here, example : Returns an index that is the specified distance from the given index.
    /// - Parameters:
    ///   - data: Image data
    ///   - stringUrl: Image URL
    private func processImageData(_ data: Data?, for stringUrl: String) {
        guard var image = UIImage(named: "noImageIcon") else {
            return
        }
        if let imageData = data, let decodedImage = UIImage(data: imageData) {
            image = decodedImage
        }
        if self.imageUrlString == stringUrl {
            self.transition(toImage: image)
        }
        CustomUIImageView.imageCache.setObject(image, forKey: NSString(string: stringUrl))
        
    }
    
    ///Animate Image transition
    /// - Parameters:
    ///   - image: Image
    private func transition(toImage image: UIImage) {
        DispatchQueue.main.async {
            UIView.transition(with: self, duration: 0.3, options: [.transitionCrossDissolve], animations: {
                self.image = image
            })
        }
        
    }
}
