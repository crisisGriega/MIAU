//
//  MarvelCharacter.swift
//  MIAU
//
//  Created by Gerardo on 25/12/2017.
//  Copyright © 2017 crisisGriega. All rights reserved.
//

import Foundation
import ObjectMapper


class MarvelCharacter: MarvelEntityRepresentable, Mappable {
    // MARK: MarvelEntityRepresentable
    var _id: String?;
    var _resourceURI: String?;
    var description: String?;
    var thumbnail: String?;
    var urls: [[String: String]]?;
    var type: MarvelEntityType = .characters;
    
    // MARK: Custom attributes
    var name: String?;
    var comics: [MarvelComicListItem]?;
    var stories: [MarvelStoryListItem]?;
    var events: [MarvelEventListItem]?;
    var series: [MarvelSerieListItem]?;
    
    
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
        self.name <- map["name"];
        self.description <- map["description"];
        self.thumbnail <- map["thumbnail.path"];
        self._resourceURI <- map["resourceURI"];
        self.comics <- map["comics.items"];
        self.stories <- map["stories.items"];
        self.events <- map["events.items"];
        self.series <- map["series.items"];
    }
}


