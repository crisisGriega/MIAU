//
//  CreatorDetailViewModel.swift
//  MIAU
//
//  Created by Gerardo on 01/01/2018.
//  Copyright © 2018 crisisGriega. All rights reserved.
//

import Foundation


class CreatorDetailViewModel: EntityDetailViewModel {
    
    var imageURL: URL? {
        return (self.entity as? MarvelCreator)?.imagePortraitURL;
    }
    
    var name: String {
        guard let name = (self.entity as? MarvelCreator)?.fullName else { return ""; }
        
        return name;
    }
    
    var description: String {
        guard let description = (self.entity as? MarvelCreator)?.description, !description.isEmpty else {
            return "No info available";
        }
        
        return description;
    }
    
    var isDetailHidden: Bool {
        return (self.entity as? MarvelCreator)?.detailURL?.isEmpty ?? true;
    }
    
    var detailURL: String? {
        return (self.entity as? MarvelCreator)?.detailURL;
    }
}
