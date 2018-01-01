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
    var type: MarvelEntityType = .characters;
    
    // MARK: Custom attributes
    var name: String?;
    var comics: [MarvelComicListItem]?;
    var creators: [MarvelCreatorListItem]?;
    var stories: [MarvelStoryListItem]?;
    var events: [MarvelEventListItem]?;
    var series: [MarvelSerieListItem]?;
    var detailURL: String?;
    var wikiURL: String?;
    var comicLink: String?;
    
    
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
        self.creators <- map["creators.items"];
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
        self.wikiURL <- (map["urls"], TransformOf<String, [StringDictionary]>(fromJSON: { (dict) -> String? in
            let filtered = dict?.filter({ (entry) -> Bool in
                return entry["type"] == "wiki";
            })
            
            if let first = filtered?.first {
                return first["url"];
            }
            
            return nil;
        }, toJSON: { (value) -> [StringDictionary]? in
            if let _value = value {
                return [["type" : "wiki", "url" : _value]];
            }
            return nil;
        }));
        self.comicLink <- (map["urls"], TransformOf<String, [StringDictionary]>(fromJSON: { (dict) -> String? in
            let filtered = dict?.filter({ (entry) -> Bool in
                return entry["type"] == "comicLink";
            })
            
            if let first = filtered?.first {
                return first["url"];
            }
            
            return nil;
        }, toJSON: { (value) -> [StringDictionary]? in
            if let _value = value {
                return [["type" : "comicLink", "url" : _value]];
            }
            return nil;
        }));
    }
}
