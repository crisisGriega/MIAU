//
//  SerieDetailViewModel.swift
//  MIAU
//
//  Created by Gerardo on 01/01/2018.
//  Copyright © 2018 crisisGriega. All rights reserved.
//

import Foundation


class SerieDetailViewModel: EntityDetailViewModel {
    
    var imageURL: URL? {
        return (self.entity as? MarvelSerie)?.imagePortraitURL;
    }
    
    var title: String {
        guard let name = (self.entity as? MarvelSerie)?.title else { return ""; }
        
        return name;
    }
    
    var description: String {
        guard let description = (self.entity as? MarvelSerie)?.description, !description.isEmpty else {
            return "No info available";
        }
        
        return description;
    }
    
    var isDetailHidden: Bool {
        return (self.entity as? MarvelSerie)?.detailURL?.isEmpty ?? true;
    }
    
    var detailURL: String? {
        return (self.entity as? MarvelSerie)?.detailURL;
    }
    
    var period: String {
        var value: String = "";
        if let start = (self.entity as? MarvelSerie)?.startYear {
            value += "\(start)";
        }
        else {
            value += "-";
        }
        value += " / ";
        if let end = (self.entity as? MarvelSerie)?.endYear {
            value += "\(end)";
        }
        else {
            value += "-";
        }
        
        return value;
    }
    
    var isPreviousHidden: Bool {
        return (self.entity as? MarvelSerie)?.previous?.name?.isEmpty ?? true;
    }
    
    var previousName: String {
        guard let value = (self.entity as? MarvelSerie)?.previous?.name else {
            return "";
        }
        return "< \(value)";
    }
    
    var previousURL: String? {
        return (self.entity as? MarvelSerie)?.previous?.resourceURI;
    }
    
    var isNextHidden: Bool {
        return (self.entity as? MarvelSerie)?.next?.name?.isEmpty ?? true;
    }
    
    var nextName: String {
        guard let value = (self.entity as? MarvelSerie)?.next?.name else {
            return "";
        }
        return  "\(value) >"
    }
    
    var nextURL: String? {
        return (self.entity as? MarvelSerie)?.next?.resourceURI;
    }
    
}
