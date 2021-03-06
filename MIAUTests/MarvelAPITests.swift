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


class MarvelAPITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAPIURLForCharacters() {
        self.commonTestingApiURLFor(.characters);
    }
    
    func testAPIURLForComics() {
        self.commonTestingApiURLFor(.comics);
    }
    
    func testAPIURLForStories() {
        self.commonTestingApiURLFor(.stories);
    }
    
    func testAPIURLForEvents() {
        self.commonTestingApiURLFor(.events);
    }
    
    func testAPIURLForSeries() {
        self.commonTestingApiURLFor(.series);
    }
}


// MARK: Private
private extension MarvelAPITests {
    func commonTestingApiURLFor(_ type: MarvelEntityType) {
        let expectation = self.expectation(description: "expectation-marvel-api-\(type)");
        
        let url = MarvelAPIConnector.default.urlFor(type);
        Alamofire.request(url).responseJSON { response in
            print("Response: \(response.result)");
            XCTAssert(response.result.error == nil);
            expectation.fulfill();
        }
        
        waitForExpectations(timeout: 120.0) { (error) in }
    }
}
