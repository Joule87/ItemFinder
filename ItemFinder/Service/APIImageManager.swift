//
//  File.swift
//  ItemFinder
//
//  Created by Julio Collado on 11/12/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import Foundation
import Alamofire

class APIImageManager {

    static func requestImage(for url: URL, complete: @escaping (Data?) -> () ) {
        let imageDataRequest = Alamofire.request(url)
        AlamofireRequest.createDataRequest(request: imageDataRequest) { dataImage in
            complete(dataImage)
        }
    }
    
}
