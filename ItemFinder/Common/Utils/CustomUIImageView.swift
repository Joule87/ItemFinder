//
//  CustomUIImageView.swift
//  ItemFinder
//
//  Created by Julio Collado on 11/12/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import UIKit

class CustomUIImageView: UIImageView {
    
    typealias Completion = (() -> Void)?
    var imageUrlString: String?
    static let imageCache = NSCache<NSString, AnyObject>()
    
    /// Fetch image from given URL String. If image was requested before i will fetch it from Cache.
    /// - Parameters:
    ///   - url: Image URL
    ///   - completion: A block object to be executed  when loadImage finished execution
    func loadImage(fromURL url: String, completion: Completion = nil) {
        self.image = nil
        imageUrlString = url
        
        if let imageFromCache = CustomUIImageView.imageCache.object(forKey: NSString(string: url)) as? UIImage {
            transition(toImage: imageFromCache, completion)
            return
        }
        
        guard let imageURL = URL(string: url) else {
            completion?()
            return
        }
        
        APIImageManager.requestImage(for: imageURL) { [weak self] data in
            guard let saveSelf = self else { return }
            saveSelf.processImageData(data, for: url, completion)
        }
        
    }
    
    /// Turn fetch data into an image and then it will save the image in Cache using stringUrl parameter as Key
    /// - Parameters:
    ///   - data: Image data
    ///   - stringUrl: Image URL
    ///   - completion: A block object to be executed  when processing data ends
    private func processImageData(_ data: Data?, for stringUrl: String, _ completion: Completion = nil) {
        guard let imageData = data, let image = UIImage(data: imageData) else {
            completion?()
            return
        }
        
        if self.imageUrlString == stringUrl {
            self.transition(toImage: image, completion)
        }
        CustomUIImageView.imageCache.setObject(image, forKey: NSString(string: stringUrl))
        
    }
    
    /// Creates a transition animation for the specified image
    /// - Parameters:
    ///   - image: Image
    private func transition(toImage image: UIImage, _ completion: Completion = nil) {
        DispatchQueue.main.async {
            UIView.transition(with: self, duration: 0.3, options: [.transitionCrossDissolve], animations: {
                self.image = image
                completion?()
            })
        }
        
    }
}
