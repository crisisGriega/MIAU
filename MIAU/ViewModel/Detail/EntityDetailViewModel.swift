//
//  EntityDetailViewModeling.swift
//  MIAU
//
//  Created by Gerardo on 01/01/2018.
//  Copyright © 2018 crisisGriega. All rights reserved.
//

import Foundation


class EntityDetailViewModel {
    var entity: MarvelEntityRepresentable? {
        didSet {
            guard let value = self.entity else {
                self.sections.removeAll();
                return;
            }
            
            self.sections.removeAll();
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
    
    var sections: [[MarvelItemListable]] = [];
    
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
