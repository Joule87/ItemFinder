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
                Logger.debug(String(describing: request.request?.description))
                ///check server  error
                if let _ = response.error, let urlStatusResponse = response.response?.status {
                    Logger.error(String(describing: response.response?.description))
                    completion(.failure(error: urlStatusResponse, data: response.data))
                    return
                }
                
                ///check alamofire error
                if let error = response.error {
                    Logger.error(String(describing: error.localizedDescription))
                    completion(.failure(error: error, data: nil))
                    return
                }
                
                guard let object = response.result.value else {
                    completion(.failure(error: HTTPStatusCode.noContent, data: response.data))
                    return
                }
                completion(.success(object))
            }
    }
    
    static func createDataRequest(request: DataRequest, completionHandler completion: @escaping (Data?) -> Void) {
        request.validate()
            .responseData {
                response in
                if let _ = response.error {
                    completion(nil)
                    return
                }
                guard let data = response.result.value else{
                    completion(nil)
                    return
                }
                completion(data)
        }
    }
    
}
