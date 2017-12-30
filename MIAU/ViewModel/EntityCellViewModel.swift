//
//  EntityCellViewModel.swift
//  MIAU
//
//  Created by Gerardo on 27/12/2017.
//  Copyright © 2017 crisisGriega. All rights reserved.
//

import UIKit


class EntityCellViewModel {
    
    var entity: MarvelEntityRepresentable?;
    
    var title: String {
        guard let entity = self.entity else {
            return "";
        }
        
        switch entity.type {
            case .characters:
                return (entity as? MarvelCharacter)?.name ?? "";
            case .comics:
                return (entity as? MarvelComic)?.title ?? "";
            case .creators:
                return (entity as? MarvelCreator)?.fullName ?? "";
            case .events:
                return (entity as? MarvelEvent)?.title ?? "";
            case .series:
                return (entity as? MarvelSerie)?.title ?? "";
            case .stories:
                return (entity as? MarvelStory)?.storyType?.rawValue ?? "";
        }
        
    }
    
    var subTitle: String {
        let defaultValue = "No info avaliable";
        
        guard let entity = self.entity else {
            return defaultValue;
        }
        
        switch entity.type {
        case .stories:
            return (entity as? MarvelStory)?.title ?? defaultValue;
        default:
            guard let des = entity.description else { return defaultValue; }
            return des.isEmpty ? defaultValue : des;
        }
    }
    
    var imagePlaceholder: UIImage? {
        guard let entity = self.entity else {
            return nil;
        }
        
        return UIImage(named: "placeholder-\(entity.type)");
    }
    
    var imageURL: URL? {
        guard let entity = self.entity else {
            return nil;
        }
        return entity.imageSquareURL;
    }
}
