//
//  MarvelEventListViewModeling.swift
//  MIAU
//
//  Created by Gerardo on 29/12/2017.
//  Copyright © 2017 crisisGriega. All rights reserved.
//

import Foundation


protocol MarvelEntityListViewModeling {
    var entityList: [MarvelEntityRepresentable] { get }
    var numberOfItems: Int { get }
    var itemsPerPage: Int { get }
    
    func itemFor(_ indexPath: IndexPath) -> MarvelEntityRepresentable?
    func retrieveData(_ completion: (([MarvelEntityRepresentable]?) -> Void)?)
}


extension MarvelEntityListViewModeling {
    
    var numberOfItems: Int {
        return self.entityList.count;
    }
    
    func itemFor(_ indexPath: IndexPath) -> MarvelEntityRepresentable? {
        guard indexPath.row >= 0, indexPath.row < entityList.count else {
            return nil;
        }
        
        return self.entityList[indexPath.row];
    }
}
