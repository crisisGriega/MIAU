//
//  ParsingTests.swift
//  MIAUTests
//
//  Created by Gerardo on 26/12/2017.
//  Copyright © 2017 crisisGriega. All rights reserved.
//

import XCTest
@testable import MIAU

import Alamofire
import ObjectMapper
import AlamofireObjectMapper


class ParsingTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSimpleCharactersParsing() {
        let expectation = self.expectation(for: .characters);
        return self.commonSimpleParsingFor(.characters, completionHandler: { (response: DataResponse<[MarvelCharacter]>) in
            XCTAssert(response.result.value?.first?.id != nil);
            XCTAssert(response.result.value?.first?.name != nil);
            expectation.fulfill();
        });
    }
    
    func testCharactersURLSParsing() {
        let expectation = self.expectation(for: .characters);
        return self.commonSimpleParsingFor(.characters, completionHandler: { (response: DataResponse<[MarvelCharacter]>) in
            defer { expectation.fulfill(); }
            guard let first = response.result.value?.first else {
                XCTAssert(false);
                return;
            }
            XCTAssert(first.detailURL != nil || first.wikiURL != nil || first.comicLink != nil);
        });
    }
    
    func testSimpleComicsParsing() {
        let expectation = self.expectation(for: .comics);
        return self.commonSimpleParsingFor(.comics, completionHandler: { (response: DataResponse<[MarvelComic]>) in
            XCTAssert(response.result.value?.first?.id != nil);
            XCTAssert(response.result.value?.first?.title != nil);
            expectation.fulfill();
        });
    }
    
    func testSimpleCreatorsParsing() {
        let expectation = self.expectation(for: .creators);
        return self.commonSimpleParsingFor(.creators, completionHandler: { (response: DataResponse<[MarvelCreator]>) in
            XCTAssert(response.result.value?.first?.id != nil);
            XCTAssert(response.result.value?.first?.fullName != "");
            expectation.fulfill();
        });
    }
    
    func testSimpleEventsParsing() {
        let expectation = self.expectation(for: .events);
        return self.commonSimpleParsingFor(.events, completionHandler: { (response: DataResponse<[MarvelEvent]>) in
            XCTAssert(response.result.value?.first?.id != nil);
            XCTAssert(response.result.value?.first?.title != nil);
            expectation.fulfill();
        });
    }
    
    func testEventPreviousNextParsing() {
        let expectation = self.expectation(for: .events);
        return self.commonSimpleParsingFor(.events, completionHandler: { (response: DataResponse<[MarvelEvent]>) in
            XCTAssert(response.result.value?.first?.previous != nil);
            XCTAssert(response.result.value?.first?.next != nil);
            expectation.fulfill();
        });
    }
    
    func testSimpleSeriesParsing() {
        let expectation = self.expectation(for: .series);
        return self.commonSimpleParsingFor(.series, completionHandler: { (response: DataResponse<[MarvelSerie]>) in
            XCTAssert(response.result.value?.first?.id != nil);
            XCTAssert(response.result.value?.first?.title != nil);
            expectation.fulfill();
        });
    }
    
    func testSerieStartYearEndYearParsing() {
        let expectation = self.expectation(for: .series);
        return self.commonSimpleParsingFor(.series, completionHandler: { (response: DataResponse<[MarvelSerie]>) in
            XCTAssert(response.result.value?.first?.startYear != nil);
            XCTAssert(response.result.value?.first?.endYear != nil);
            expectation.fulfill();
        });
    }
    
    func testSimpleStoriesParsing() {
        let expectation = self.expectation(for: .stories);
        return self.commonSimpleParsingFor(.stories, completionHandler: { (response: DataResponse<[MarvelStory]>) in
            XCTAssert(response.result.value?.first?.id != nil);
            XCTAssert(response.result.value?.first?.title != nil);
            XCTAssert(response.result.value?.first?.storyType != nil);
            expectation.fulfill();
        });
    }
}

private extension ParsingTests {
    func expectation(for type: MarvelEntityType) -> XCTestExpectation {
        return self.expectation(description: "expectation-parsing-to-\(type)");
    }
    
    func commonSimpleParsingFor<T>(_ type: MarvelEntityType, completionHandler:@escaping (DataResponse<[T]>) -> Void) where T: BaseMappable, T: MarvelEntityRepresentable {
        let url = MarvelAPIConnector.default.urlFor(type);

        Alamofire.request(url).responseArray(keyPath: "data.results", completionHandler: completionHandler)
        waitForExpectations(timeout: 120.0) { (error) in }
    }
}

