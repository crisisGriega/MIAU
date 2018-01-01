//
//  CharacterDetailViewModel.swift
//  MIAU
//
//  Created by Gerardo on 31/12/2017.
//  Copyright © 2017 crisisGriega. All rights reserved.
//

import UIKit


class CharacterDetailViewModel: EntityDetailViewModel {
    
    var imageURL: URL? {
        return (self.entity as? MarvelCharacter)?.imagePortraitURL;
    }
    
    var name: String {
        guard let name = (self.entity as? MarvelCharacter)?.name else { return ""; }
        
        return name;
    }
    
    var description: String {
        guard let description = (self.entity as? MarvelCharacter)?.description, !description.isEmpty else {
            return "No info available";
        }
        
        return description;
    }
    
    var isDetailHidden: Bool {
        return (self.entity as? MarvelCharacter)?.detailURL?.isEmpty ?? true;
    }
    
    var detailURL: String? {
        return (self.entity as? MarvelCharacter)?.detailURL;
    }
    
    var isWikiHidden: Bool {
        return (self.entity as? MarvelCharacter)?.wikiURL?.isEmpty ?? true;
    }
    
    var wikiURL: String? {
        return (self.entity as? MarvelCharacter)?.wikiURL;
    }
    
    var isComicLinkHidden: Bool {
        return (self.entity as? MarvelCharacter)?.comicLink?.isEmpty ?? true;
    }
    
    var comicLinkURL: String? {
        return (self.entity as? MarvelCharacter)?.comicLink;
    }
}
