//
//  MarvelCreatorListItem.swift
//  MIAU
//
//  Created by Gerardo on 26/12/2017.
//  Copyright © 2017 crisisGriega. All rights reserved.
//

import Foundation
import ObjectMapper


struct MarvelCreatorListItem: MarvelItemListable, Mappable {
    var _id: String?;
    var _resourceURI: String?;
    var type: MarvelEntityType { return .creators }
    var name: String?;
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        self._resourceURI <- map["resourceURI"];
        self.name <- map["name"];
    }
}
