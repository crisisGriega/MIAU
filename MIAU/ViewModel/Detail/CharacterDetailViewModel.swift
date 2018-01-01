//
//  CharacterDetailViewModel.swift
//  MIAU
//
//  Created by Gerardo on 31/12/2017.
//  Copyright © 2017 crisisGriega. All rights reserved.
//

import UIKit


class CharacterDetailViewModel {
    var character: MarvelCharacter? {
        didSet {
            guard let value = self.character else {
                self.sections.removeAll();
                return;
            }
            
            if let comics = value.comics, !comics.isEmpty {
                self.sections.append(comics);
            }
            if let creators = value.creators, !creators.isEmpty {
                self.sections.append(creators);
            }
            if let events = value.events, !events.isEmpty {
                self.sections.append(events);
            }
            if let series = value.series, !series.isEmpty {
                self.sections.append(series);
            }
            if let stories = value.stories, !stories.isEmpty {
                self.sections.append(stories);
            }
        }
    }
    
    private var sections: [[MarvelItemListable]] = [];
    
    var imageURL: URL? {
        return character?.imagePortraitURL;
    }
    
    var name: String {
        guard let name = self.character?.name else { return ""; }
        
        return name;
    }
    
    var description: String {
        guard let description = self.character?.description, !description.isEmpty else {
            return "No info available";
        }
        
        return description;
    }
    
    var isDetailHidden: Bool {
        return self.character?.detailURL?.isEmpty ?? true;
    }
    
    var detailURL: String? {
        return self.character?.detailURL;
    }
    
    var isWikiHidden: Bool {
        return self.character?.wikiURL?.isEmpty ?? true;
    }
    
    var wikiURL: String? {
        return self.character?.wikiURL;
    }
    
    var isComicLinkHidden: Bool {
        return self.character?.comicLink?.isEmpty ?? true;
    }
    
    var comicLinkURL: String? {
        return self.character?.comicLink;
    }
    
    // Feed for tableView
    var numberOfSections: Int {
        return self.sections.count;
    }
    
    func numberOfItems(forSection section: Int) -> Int {
        return self.sections[section].count;
    }
    
    func itemFor(_ indexPath: IndexPath) -> MarvelItemListable {
        return self.sections[indexPath.section][indexPath.row];
    }
    
    func titleForSection(atIndex index: Int) -> String {
        guard let first = self.sections[index].first else { return "" }
        
        return first.type.rawValue;
    }
}
