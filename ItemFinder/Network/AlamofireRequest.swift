//
//  AlamofireRequest.swift
//  ItemFinder
//
//  Created by Julio Collado on 11/9/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import Foundation

import Alamofire
import ObjectMapper
import AlamofireObjectMapper

public class AlamofireRequest {
    
    static func createObjectRequest<T: Mappable> (request: DataRequest, completionHandler completion: @escaping (Result<T>) -> Void) {
        request.validate()
            .responseObject {
                (response: DataResponse<T>) in
                if let _ = response.error, let urlStatusResponse = response.response?.status {
                    completion(.failure(error: urlStatusResponse, data: response.data))
                    return
                }
                guard let object = response.result.value else{
                    completion(.failure(error: HTTPStatusCode.noContent, data: response.data))
                    return
                }
                completion(.success(object))
            }
    }
    
}
