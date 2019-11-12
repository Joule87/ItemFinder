//
//  Result.swift
//  ItemFinder
//
//  Created by Julio Collado on 11/9/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import Foundation

public enum Result<Value> {
    case success(Value)
    case failure(error:Error, data: Data?)
}
