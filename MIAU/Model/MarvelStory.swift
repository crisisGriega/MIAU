//
//  MarvelStory.swift
//  MIAU
//
//  Created by Gerardo on 27/12/2017.
//  Copyright © 2017 crisisGriega. All rights reserved.
//

import Foundation
import ObjectMapper


class MarvelStory: MarvelEntityRepresentable, Mappable {
    
    // MARK: MarvelEntityRepresentable
    var _id: String?;
    var _resourceURI: String?;
    var description: String?;
    var thumbnail: String?;
    var type: MarvelEntityType = .stories;
    
    // MARK: Custom attributes
    var title: String?;
    var characters: [MarvelCharacter]?;
    var comics: [MarvelComicListItem]?;
    var creators: [MarvelCreatorListItem]?;
    var events: [MarvelEventListItem]?;
    var series: [MarvelSerieListItem]?;
    var originalIssue: MarvelComicListItem?;
    var storyType: StoryType?;
    
    
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
        self.title <- map["title"];
        self.characters <- map["characters.items"];
        self.comics <- map["comics.items"];
        self.creators <- map["creators.items"];
        self.events <- map["events.items"];
        self.series <- map["series.items"];
        self.originalIssue <- map["originalIssue"];
        self.storyType <- (map["type"], TransformOf<StoryType, String>(fromJSON: { (type) -> StoryType? in
            if let _type = type, let st = StoryType(rawValue: _type) {
                return st;
            }
            return nil;
        }, toJSON: { (value) -> String? in
            return value?.rawValue;
        }));
    }
}
