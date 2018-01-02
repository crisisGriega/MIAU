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
    
    static let `default`: DataProvider = DataProvider();
    
    private let apiConnector: MarvelAPIConnector = MarvelAPIConnector();
    
    @discardableResult func getEntityList<Entity: Mappable>(of entityType: MarvelEntityType, limit: Int? = 20, offset: Int? = nil, queryCondition: String? = nil, completion: @escaping (Result<[Entity]>) -> Void) -> DataRequest  where Entity: MarvelEntityRepresentable {
        var args: [String: String] = [:];
        
        if let _limit = limit {
            args["limit"] = String(_limit);
        }
        if let _offset = offset {
            args["offset"] = String(_offset);
        }
        
        if let condition = queryCondition, let key = self.queryArgFor(entityType) {
            args[key] = condition.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed);
        }
        args["orderBy"] = self.orderByFor(entityType);
        
        let url = self.apiConnector.urlFor(entityType, args: args);
        let request = Alamofire.request(url).responseArray(keyPath: "data.results") { (response: DataResponse<[Entity]>) in
            completion(response.result);
        }
        
        return request;
    }
    
    @discardableResult func getEntity<Entity: Mappable>(of entityType: MarvelEntityType, withURL uri: String, completion: @escaping (Result<[Entity]>) -> Void) -> DataRequest  where Entity: MarvelEntityRepresentable {
        let args = ["limit": "1"];
        let url = self.apiConnector.urlFor(uri, args: args);
        let request = Alamofire.request(url).responseArray(keyPath: "data.results") { (response: DataResponse<[Entity]>) in
            completion(response.result);
        }
        
        return request;
    }
}


// MARK: Private
private extension DataProvider {
    func queryArgFor(_ entityType: MarvelEntityType) -> String? {
        switch entityType {
            case .characters, .creators, .events:
                return "nameStartsWith";
            case .comics, .series:
                return "titleStartsWith";
            default:
                return nil;
        }
    }
    
    func orderByFor(_ entityType: MarvelEntityType) -> String {
        switch entityType {
            case .characters:
                return "name";
            case .comics:
                return "title,issueNumber";
            case .creators:
                return "firstName,lastName";
            case  .events:
                return "name,startDate";
            case .series:
                return "title,startYear";
            case .stories:
                return "id";
        }
    }
}
