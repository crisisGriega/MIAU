//
//  MarvelSerie.swift
//  MIAU
//
//  Created by Gerardo on 26/12/2017.
//  Copyright © 2017 crisisGriega. All rights reserved.
//

import Foundation
import ObjectMapper


class MarvelSerie: MarvelEntityRepresentable, Mappable {
    
    // MARK: MarvelEntityRepresentable
    var _id: String?;
    var _resourceURI: String?;
    var description: String?;
    var thumbnail: String?;
    var type: MarvelEntityType = .series;
    
    // MARK: Custom attributes
    var title: String?;
    var characters: [MarvelCharacterListItem]?;
    var comics: [MarvelComicListItem]?;
    var creators: [MarvelCreatorListItem]?;
    var events: [MarvelEventListItem]?;
    var series: [MarvelSerieListItem]?;
    var stories: [MarvelStoryListItem]?;
    var startYear: Int?;
    var endYear: Int?;
    var rating: String?;
    var previous: MarvelSerieListItem?;
    var next: MarvelSerieListItem?;
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
        self.title <- map["title"];
        self.characters <- map["characters.items"];
        self.comics <- map["comics.items"];
        self.creators <- map["creators.items"];
        self.events <- map["events.items"];
        self.stories <- map["stories.items"];
        self.startYear <- map["startYear"];
        self.endYear <- map["endYear"];
        self.rating <- map["rating"];
        self.previous <- map["previous"];
        self.next <- map["next"];
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
