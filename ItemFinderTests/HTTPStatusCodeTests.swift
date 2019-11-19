//
//  HTTPStatusCodeTests.swift
//  ItemFinderTests
//
//  Created by Julio Collado on 11/19/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import Foundation
import XCTest
@testable import ItemFinder

class HTTPStatusCodeTests: XCTestCase {
    var statusCode: HTTPStatusCode?
    
    override func setUp() {
        
    }
    
    override func tearDown() {
        statusCode = nil
    }
    
    func test_ResponseType_InformationCode() {
        statusCode = HTTPStatusCode(rawValue: 101)
        XCTAssertEqual(statusCode?.responseType, HTTPStatusCode.ResponseType.informational)
        
        statusCode = HTTPStatusCode(rawValue: 102)
        XCTAssertEqual(statusCode?.responseType, HTTPStatusCode.ResponseType.informational)
        
        statusCode = HTTPStatusCode(rawValue: 400)
        XCTAssertNotEqual(statusCode?.responseType, HTTPStatusCode.ResponseType.informational)
    }
    
    func test_ResponseType_SuccessCode() {
        statusCode = HTTPStatusCode(rawValue: 200)
        XCTAssertEqual(statusCode?.responseType, HTTPStatusCode.ResponseType.success)
        
        statusCode = HTTPStatusCode(rawValue: 226)
        XCTAssertEqual(statusCode?.responseType, HTTPStatusCode.ResponseType.success)
        
        statusCode = HTTPStatusCode(rawValue: 300)
        XCTAssertNotEqual(statusCode?.responseType, HTTPStatusCode.ResponseType.success)
    }
    
    func test_ResponseType_RedirectionCode() {
        statusCode = HTTPStatusCode(rawValue: 300)
        XCTAssertEqual(statusCode?.responseType, HTTPStatusCode.ResponseType.redirection)
        
        statusCode = HTTPStatusCode(rawValue: 308)
        XCTAssertEqual(statusCode?.responseType, HTTPStatusCode.ResponseType.redirection)
        
        statusCode = HTTPStatusCode(rawValue: 400)
        XCTAssertNotEqual(statusCode?.responseType, HTTPStatusCode.ResponseType.redirection)
    }
    
    func test_ResponseType_ClientErrorCode() {
        statusCode = HTTPStatusCode(rawValue: 400)
        XCTAssertEqual(statusCode?.responseType, HTTPStatusCode.ResponseType.clientError)
        
        statusCode = HTTPStatusCode(rawValue: 499)
        XCTAssertEqual(statusCode?.responseType, HTTPStatusCode.ResponseType.clientError)
        
        statusCode = HTTPStatusCode(rawValue: 101)
        XCTAssertNotEqual(statusCode?.responseType, HTTPStatusCode.ResponseType.clientError)
    }
    
    func test_ResponseType_ServerErrorCode() {
        statusCode = HTTPStatusCode(rawValue: 500)
        XCTAssertEqual(statusCode?.responseType, HTTPStatusCode.ResponseType.serverError)
        
        statusCode = HTTPStatusCode(rawValue: 511)
        XCTAssertEqual(statusCode?.responseType, HTTPStatusCode.ResponseType.serverError)
        
        statusCode = HTTPStatusCode(rawValue: 300)
        XCTAssertNotEqual(statusCode?.responseType, HTTPStatusCode.ResponseType.serverError)
    }
    
    func test_Description_InformationCode() {
        statusCode = HTTPStatusCode(rawValue: 101)
        XCTAssertNil(statusCode?.description)
    }
    
    func test_Description_SuccessCode() {
        statusCode = HTTPStatusCode(rawValue: 201)
        XCTAssertNil(statusCode?.description)
    }
    
    func test_Description_RedirectionCode() {
        statusCode = HTTPStatusCode(rawValue: 300)
        XCTAssertEqual(statusCode?.description, "error.range300".localized)
    }
    
    func test_Description_ClientErrorCode() {
        statusCode = HTTPStatusCode(rawValue: 400)
        XCTAssertEqual(statusCode?.description, "error.range400".localized)
    }
    
    func test_Description_ServerErrorCode() {
        statusCode = HTTPStatusCode(rawValue: 500)
        XCTAssertEqual(statusCode?.description, "error.range500".localized)
    }
    
}
