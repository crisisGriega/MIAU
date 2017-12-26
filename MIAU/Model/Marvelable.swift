//
//  Marvelable.swift
//  MIAU
//
//  Created by Gerardo on 26/12/2017.
//  Copyright © 2017 crisisGriega. All rights reserved.
//

import Foundation


protocol Marvelable {
    var _id: String? { get set }
    var _resourceURI: String? { get set }
    var type: MarvelEntityType { get }
}

// ID and resourceURI can be translated into each other
extension Marvelable {
    var id: String? {
        if let value = _id {
            return value;
        }
        else if let value = _resourceURI {
            let components = value.components(separatedBy: "/");
            if let index = components.index(of: self.type.rawValue), index < components.count - 1 {
                return components[index+1];
            }
        }
        return nil;
    }
    
    var resourceURI: String? {
        get {
            if let value = _resourceURI {
                return value;
            }
            else if let value = _id {
                return MarvelAPIConnector.default.urlFor(self.type, id: value);
            }
            return nil;
        }
    }
}


// MARK: Equatable
extension Marvelable {
    static func ==(lhs: Marvelable, rhs: Marvelable) -> Bool {
        return lhs.type == rhs.type && lhs.id == rhs.id && lhs.id != nil && lhs.id != "";
    }
}
