//
//  MarvelEvent.swift
//  MIAU
//
//  Created by Gerardo on 26/12/2017.
//  Copyright © 2017 crisisGriega. All rights reserved.
//

import Foundation
import ObjectMapper


class MarvelEvent: MarvelEntityRepresentable, Mappable {
    
    // MARK: MarvelEntityRepresentable
    var _id: String?;
    var _resourceURI: String?;
    var description: String?;
    var thumbnail: String?;
    var type: MarvelEntityType = .events;
    
    // MARK: Custom attributes
    var title: String?;
    var characters: [MarvelCharacterListItem]?;
    var comics: [MarvelComicListItem]?;
    var creators: [MarvelCreatorListItem]?;
    var events: [MarvelEventListItem]?;
    var series: [MarvelSerieListItem]?;
    var stories: [MarvelStoryListItem]?;
    var start: Date?;
    var end: Date?;
    var previous: MarvelEventListItem?;
    var next: MarvelEventListItem?;
    var detailURL: String?;
    var wikiURL: String?;
    
    
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
        self.series <- map["series.items"];
        self.stories <- map["stories.items"];
        
        let dateFormatter = DateFormatter(withFormat: "yyyy-MM-dd HH:mm:ss", locale: "en_US");
        let UTCTransform = TransformOf<Date, String>(fromJSON: { (value) -> Date? in
            guard let _value = value else { return nil; }
            return dateFormatter.date(from: _value);
        }, toJSON: { (value) -> String? in
            guard let _value = value else { return nil; }
            return dateFormatter.string(from: _value);
        })
        self.start <- (map["start"], UTCTransform);
        self.end <- (map["end"], UTCTransform);
        
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
    }
}
