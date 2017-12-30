//
//  DataProviderTests.swift
//  MIAUTests
//
//  Created by Gerardo on 30/12/2017.
//  Copyright © 2017 crisisGriega. All rights reserved.
//

import XCTest
@testable import MIAU

import Alamofire
import ObjectMapper
import AlamofireObjectMapper


class DataProviderTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testDataProviderSearchForCreator() {
        let expectation = self.expectation(description: "expectation-data-provider-search-creator");
        
        let provider = DataProvider();
        
        provider.getEntityList(of: .creators, limit: 100, offset: 0, queryCondition: "iban") { (result: Result<[MarvelCreator]>) in
            XCTAssert(result.value?.first?.fullName == "Iban  Coello");
            
            expectation.fulfill();
        }
        
        waitForExpectations(timeout: 120.0) { (error) in }
    }
}
