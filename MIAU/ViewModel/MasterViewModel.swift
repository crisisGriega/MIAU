//
//  MasterViewModel.swift
//  MIAU
//
//  Created by Gerardo on 27/12/2017.
//  Copyright © 2017 crisisGriega. All rights reserved.
//

import UIKit


class MasterViewModel {
    
    private var entityList: [MarvelEntityRepresentable] = [];
    private let entityTypes: [MarvelEntityType] = [.characters, .comics, .creators, .events, .series, .stories];
    private let itemsPerPage: Int = 100;
    private var page: Int = 1;
    private var isRetrieving: Bool = false;
    
    // Types
    var numberOfTypes: Int {
        return self.entityTypes.count;
    }
    
    func nameForTypeAtIndex(_ index: Int) -> String {
        guard index >= 0, index < self.entityTypes.count else {
            return "";
        }
        
        return self.entityTypes[index].rawValue;
    }
    
    var selectedTypeIndex: Int = 0 {
        didSet {
            // TODO: Need to retrieve new data
        }
    }
    
    // List
    var numberOfItems: Int {
        return self.entityList.count
    }
    
    var marginForRetrieving: CGFloat {
        return (self.cellHeight) * CGFloat(self.itemsPerPage / 2);
    }
    
    var cellHeight: CGFloat {
        return 60.0;
    }
    
    func itemFor(_ indexPath: IndexPath) -> MarvelEntityRepresentable? {
        guard indexPath.row >= 0, indexPath.row < entityList.count else {
            return nil;
        }
        
        return self.entityList[indexPath.row];
    }
    
    func retrieveData(_ completion: (([MarvelEntityRepresentable]?) -> Void)?) {
        if self.isRetrieving {
            if let _completion = completion {
                _completion(nil);
            }
            return;
        }
        self.isRetrieving = true;
        DataProvider.getCharacterList(limit: self.itemsPerPage, offset: self.itemsPerPage * (self.page-1)) { (result) in
            self.isRetrieving = false;
            defer {
                if let _completion = completion {
                    _completion(result.value);
                }
            }
            
            if result.isSuccess, let value = result.value {
                self.entityList.append(contentsOf: (value as [MarvelEntityRepresentable]));
                self.page += 1;
            }
        }
    }
}
