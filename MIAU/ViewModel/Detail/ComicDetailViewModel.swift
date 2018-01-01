//
//  ComicDetailViewModel.swift
//  MIAU
//
//  Created by Gerardo on 01/01/2018.
//  Copyright © 2018 crisisGriega. All rights reserved.
//

import Foundation


class ComicDetailViewModel: EntityDetailViewModel {
    
    var imageURL: URL? {
        return (self.entity as? MarvelComic)?.imagePortraitURL;
    }
    
    var name: String {
        guard let name = (self.entity as? MarvelComic)?.title else { return ""; }
        
        return name;
    }
    
    var description: String {
        guard let description = (self.entity as? MarvelComic)?.description, !description.isEmpty else {
            return "No info available";
        }
        
        return description;
    }
}
