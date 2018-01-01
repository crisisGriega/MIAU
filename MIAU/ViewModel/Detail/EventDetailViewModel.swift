//
//  EventDetailViewModel.swift
//  MIAU
//
//  Created by Gerardo on 01/01/2018.
//  Copyright © 2018 crisisGriega. All rights reserved.
//

import Foundation


class EventDetailViewModel: EntityDetailViewModel {
    
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter();
        dateFormatter.dateStyle = .medium;
        dateFormatter.timeStyle = .none;
        return dateFormatter;
    }();
    
    
    var imageURL: URL? {
        return (self.entity as? MarvelEvent)?.imagePortraitURL;
    }
    
    var title: String {
        guard let name = (self.entity as? MarvelEvent)?.title else { return ""; }
        
        return name;
    }
    
    var description: String {
        guard let description = (self.entity as? MarvelEvent)?.description, !description.isEmpty else {
            return "No info available";
        }
        
        return description;
    }
    
    var isDetailHidden: Bool {
        return (self.entity as? MarvelEvent)?.detailURL?.isEmpty ?? true;
    }
    
    var detailURL: String? {
        return (self.entity as? MarvelEvent)?.detailURL;
    }
    
    var isWikiHidden: Bool {
        return (self.entity as? MarvelEvent)?.wikiURL?.isEmpty ?? true;
    }
    
    var wikiURL: String? {
        return (self.entity as? MarvelEvent)?.wikiURL;
    }
    
    var period: String {
        var value: String = "";
        if let start = (self.entity as? MarvelEvent)?.start {
            let startString = self.dateFormatter.string(from: start);
            value += startString;
        }
        else {
            value += "-";
        }
        value += " / ";
        if let end = (self.entity as? MarvelEvent)?.start {
            let endString = self.dateFormatter.string(from: end);
            value += endString;
        }
        else {
            value += "-";
        }
        
        return value;
    }
    
    var isPreviousHidden: Bool {
        return (self.entity as? MarvelEvent)?.previous?.name?.isEmpty ?? true;
    }
    
    var previousName: String {
        guard let value = (self.entity as? MarvelEvent)?.previous?.name else {
            return "";
        }
        return "< \(value)";
    }
    
    var previousURL: String? {
        return (self.entity as? MarvelEvent)?.previous?.resourceURI;
    }
    
    var isNextHidden: Bool {
        return (self.entity as? MarvelEvent)?.next?.name?.isEmpty ?? true;
    }
    
    var nextName: String {
        guard let value = (self.entity as? MarvelEvent)?.next?.name else {
            return "";
        }
        return  "\(value) >"
    }
    
    var nextURL: String? {
        return (self.entity as? MarvelEvent)?.next?.resourceURI;
    }
}
