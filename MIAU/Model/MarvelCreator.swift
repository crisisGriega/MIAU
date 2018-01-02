//
//  MarvelCreator.swift
//  MIAU
//
//  Created by Gerardo on 26/12/2017.
//  Copyright © 2017 crisisGriega. All rights reserved.
//

import Foundation
import ObjectMapper


class MarvelCreator: MarvelEntityRepresentable, Mappable {
    
    // MARK: MarvelEntityRepresentable
    var _id: String?;
    var _resourceURI: String?;
    var description: String?;
    var thumbnail: String?;
    var type: MarvelEntityType = .creators;
    
    // MARK: Custom attributes
    var firstName: String?;
    var middleName: String?;
    var lastName: String?;
    var fullName: String {
        var _fullName: String = ""
        if let first = self.firstName {
            _fullName += first
        }
        if let middle = self.middleName {
            _fullName += " \(middle)";
        }
        if let last = self.lastName {
            _fullName += " \(last)";
        }
        
        return _fullName;
    }
    var characters: [MarvelCharacterListItem]?;
    var comics: [MarvelComicListItem]?;
    var creators: [MarvelCreatorListItem]?;
    var events: [MarvelEventListItem]?;
    var series: [MarvelSerieListItem]?;
    var stories: [MarvelStoryListItem]?;
    var detailURL: String?;
    
    
    // MARK: Mappable
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        self._id <- (map["id"], TransformOf<String, Int>(fromJSON: { (intID) -> String? in
            if let _intID = intID {
                return String(_intID);
            }
            return nil;
        }, toJSON: { (value) -> Int? in
            if let _value = value, let intValue = Int(_value) {
                return intValue;
            }
            return nil;
        }));
        self.description <- map["description"];
        self.thumbnail <- map["thumbnail.path"];
        self._resourceURI <- map["resourceURI"];
        self.characters <- map["characters.items"];
        self.firstName <- map["firstName"];
        self.middleName <- map["middleName"];
        self.lastName <- map["lastName"];
        self.characters <- map["characters.items"];
        self.comics <- map["comics.items"];
        self.events <- map["events.items"];
        self.series <- map["series.items"];
        self.stories <- map["stories.items"];
        self.detailURL <- (map["urls"], TransformOf<String, [StringDictionary]>(fromJSON: { (dict) -> String? in
            let filtered = dict?.filter({ (entry) -> Bool in
                return entry["type"] == "detail";
            })
            
            if let first = filtered?.first {
                return first["url"];
            }
            
            return nil;
        }, toJSON: { (value) -> [StringDictionary]? in
            if let _value = value {
                return [["type" : "detail", "url" : _value]];
            }
            return nil;
        }));
    }
}
