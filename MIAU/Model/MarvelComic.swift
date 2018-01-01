//
//  MarvelComic.swift
//  MIAU
//
//  Created by Gerardo on 26/12/2017.
//  Copyright © 2017 crisisGriega. All rights reserved.
//

import Foundation
import ObjectMapper


class MarvelComic: MarvelEntityRepresentable, Mappable {
    
    // MARK: MarvelEntityRepresentable
    var _id: String?;
    var _resourceURI: String?;
    var description: String?;
    var thumbnail: String?;
    var type: MarvelEntityType = .comics;
    
    // MARK: Custom attributes
    var title: String?;
    var detailURL: String?;
    var isbn: String?;
    var upc: String?;
    var diamondCode: String?;
    var ean: String?;
    var issn: String?;
    var format: String?;
    var pageCount: Int?;
    var date: Date?;
    var price: Float?;
    var characters: [MarvelCharacterListItem]?;
    var comics: [MarvelComicListItem]?;
    var creators: [MarvelCreatorListItem]?;
    var events: [MarvelEventListItem]?;
    var series: [MarvelSerieListItem]?;
    var stories: [MarvelStoryListItem]?;
    
    
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
        self.characters <- map["characters.items"];
        self.creators <- map["creators.items"];
        self.events <- map["events.items"];
        self.series <- map["series.items"];
        self.stories <- map["stories.items"];
    }
}
