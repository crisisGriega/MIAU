//
//  EventsListViewModel.swift
//  MIAU
//
//  Created by Gerardo on 30/12/2017.
//  Copyright © 2017 crisisGriega. All rights reserved.
//

import Foundation
import Alamofire


class EventsListViewModel: MarvelEntityListViewModeling {
    let dataProvider: DataProvider = DataProvider();
    private var list: [MarvelEvent] = [];
    var entityList: [MarvelEntityRepresentable] {
        return self.list;
    }
    
    var entityType: MarvelEntityType {
        return .events;
    }
    
    private var isRetrieving: Bool = false;
    private var page: Int = 1;
    
    func retrieveData(_ completion: (([MarvelEntityRepresentable]?) -> Void)?) {
        if self.isRetrieving {
            if let _completion = completion {
                _completion(nil);
            }
            return;
        }
        self.isRetrieving = true;
        let offset: Int = self.itemsPerPage * (self.page-1);
        self.dataProvider.getEntityList(of: self.entityType, limit: self.itemsPerPage, offset: offset) { (result: Result<[MarvelEvent]>) in
            self.isRetrieving = false;
            defer {
                if let _completion = completion {
                    _completion(result.value);
                }
            }
            
            if result.isSuccess, let value = result.value {
                self.list.append(contentsOf: value);
                self.page += 1;
            }
        }
    }
}
