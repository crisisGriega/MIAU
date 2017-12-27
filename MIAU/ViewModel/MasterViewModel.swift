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
    private let itemsPerPage: Int = 100;
    private var page: Int = 1;
    private var isRetrieving: Bool = false;
    
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
        if self.isRetrieving { return; }
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
