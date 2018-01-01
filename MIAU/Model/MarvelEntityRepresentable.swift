//
//  MarvelEntityRepresentable.swift
//  MIAU
//
//  Created by Gerardo on 24/12/2017.
//  Copyright © 2017 crisisGriega. All rights reserved.
//

import Foundation

typealias StringDictionary = [String : String];

protocol MarvelEntityRepresentable: Marvelable {
    var description: String? { get set }
    var thumbnail: String? { get set }
    var characters: [MarvelCharacterListItem]? { get set }
    var comics: [MarvelComicListItem]? { get set }
    var creators: [MarvelCreatorListItem]? { get set }
    var stories: [MarvelStoryListItem]? { get set }
    var events: [MarvelEventListItem]? { get set }
    var series: [MarvelSerieListItem]? { get set }
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
