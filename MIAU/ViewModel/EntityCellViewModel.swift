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
            default:
                return "";
        }
        
    }
    
    var subTitle: String {
        guard let entity = self.entity else {
            return ""
        }
        
        switch entity.type {
            case .characters:
                let defaultValue = "No info avaliable";
                guard let des = entity.description else { return defaultValue; }
                return des.isEmpty ? defaultValue : des;
            default:
                return "";
        }
    }
    
    var imagePlaceholder: UIImage? {
        guard let entity = self.entity else {
            return nil;
        }
        
        switch entity.type {
            case .characters:
                return #imageLiteral(resourceName: "placeholder-characters");
            default:
                return nil;
        }
            
    }
    
    var imageURL: URL? {
        guard let entity = self.entity else {
            return nil;
        }
        
        switch entity.type {
            case .characters:
                return entity.imageSquareURL;
            default:
                return nil;
        }
    }
}