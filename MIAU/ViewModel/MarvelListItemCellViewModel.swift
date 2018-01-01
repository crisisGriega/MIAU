//
//  MarvelListItemCellViewModel.swift
//  MIAU
//
//  Created by Gerardo on 01/01/2018.
//  Copyright © 2018 crisisGriega. All rights reserved.
//

import Foundation


class MarvelListItemCellViewModel {
    var item: MarvelItemListable?
    
    var name: String {
        return item?.name ?? "";
    }
    
    var detail: String? {
        guard let item = self.item, item.type == .stories else { return nil; }
        return (item as? MarvelStoryListItem)?.storyType?.rawValue;
    }
    
    var url: String? {
        return item?.resourceURI;
    }
}
