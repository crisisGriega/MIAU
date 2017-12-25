//
//  MarvelAPITest.swift
//  MIAUTests
//
//  Created by Gerardo on 25/12/2017.
//  Copyright © 2017 crisisGriega. All rights reserved.
//

import XCTest
@testable import MIAU

import Alamofire
import ObjectMapper
import AlamofireObjectMapper


class MarvelAPITest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAPIURLForCharacters() {
        let expectation = self.expectation(description: "expectation-data-provider-characters");
        
        let url = MarvelAPIConnector.default.urlFor(.characters);
        Alamofire.request(url).responseJSON { response in
            print("Response: \(response.result)");
            XCTAssert(response.result.error == nil);
            expectation.fulfill();
        }
        
        waitForExpectations(timeout: 120.0) { (error) in }
    }
    
}
