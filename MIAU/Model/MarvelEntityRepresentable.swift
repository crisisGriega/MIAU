//
//  MarvelEntityRepresentable.swift
//  MIAU
//
//  Created by Gerardo on 24/12/2017.
//  Copyright © 2017 crisisGriega. All rights reserved.
//

import Foundation


protocol MarvelEntityRepresentable {
    var _id: String? { get set }
    var _resourceURI: String? { get set }
    var description: String? { get set }
    var thumbnail: String? { get set }
    var type: MarvelEntityType { get }
}


// ID and resourceURI can be translated into each other
extension MarvelEntityRepresentable {
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


// MARK: Images URL
extension MarvelEntityRepresentable {
    var imagePortraitURL: URL? {
        return self.imageURLFor(.portrait);
    }
    
    var imageSquareURL: URL? {
        return self.imageURLFor(.square);
    }
    
    var imageLandscapeURL: URL? {
        return self.imageURLFor(.landscape);
    }
    
    var imageDetailURL: URL? {
        return self.imageURLFor(.detail);
    }
}


// MARK: Private
private extension MarvelEntityRepresentable {
    func imageURLFor(_ imageSize: MarvelImageSize) -> URL? {
        guard let path = self.thumbnail, let url = URL(string: path) else { return nil; }
        return url.appendingPathComponent(imageSize.rawValue);
    }
}
