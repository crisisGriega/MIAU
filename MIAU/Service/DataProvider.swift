//
//  DataProvider.swift
//  MIAU
//
//  Created by Gerardo on 27/12/2017.
//  Copyright © 2017 crisisGriega. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper


class DataProvider {
    static let apiConnector: MarvelAPIConnector = MarvelAPIConnector();
    
    static func getCharacterList(limit: Int? = 20, offset: Int? = nil, completion: @escaping (Result<[MarvelCharacter]>) -> Void) {
        var args: [String: String] = [:];
        
        if let _limit = limit {
            args["limit"] = String(_limit);
        }
        if let _offset = offset {
            args["offset"] = String(_offset);
        }
        
        let url = self.apiConnector.urlFor(.characters, args: args);
        Alamofire.request(url).responseArray(keyPath: "data.results") { (response: DataResponse<[MarvelCharacter]>) in
            completion(response.result);
        }
    }
    
    static func getEntityList<Entity: Mappable>(of entityType: MarvelEntityType, limit: Int? = 20, offset: Int? = nil, completion: @escaping (Result<[Entity]>) -> Void) where Entity: MarvelEntityRepresentable {
        var args: [String: String] = [:];
        
        if let _limit = limit {
            args["limit"] = String(_limit);
        }
        if let _offset = offset {
            args["offset"] = String(_offset);
        }
        
        let url = self.apiConnector.urlFor(entityType, args: args);
        Alamofire.request(url).responseArray(keyPath: "data.results") { (response: DataResponse<[Entity]>) in
            completion(response.result);
        }
    }
}
