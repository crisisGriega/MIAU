//
//  StoryListItem.swift
//  MIAU
//
//  Created by Gerardo on 26/12/2017.
//  Copyright © 2017 crisisGriega. All rights reserved.
//

import Foundation
import ObjectMapper


// MARK: StoryType
enum StoryType: String {
    case cover;
    case interiorStory;
}


// MARK: MarvelStoryListItem
struct MarvelStoryListItem: MarvelItemListable, Mappable {
    var _id: String?;
    var _resourceURI: String?;
    var type: MarvelEntityType { return .stories }
    var name: String?;
    var storyType: StoryType?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        self._resourceURI <- map["resourceURI"];
        self.name <- map["name"];
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
