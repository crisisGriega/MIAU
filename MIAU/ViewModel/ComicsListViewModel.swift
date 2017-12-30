//
//  ComicsListViewModel.swift
//  MIAU
//
//  Created by Gerardo on 29/12/2017.
//  Copyright © 2017 crisisGriega. All rights reserved.
//

import Foundation
import Alamofire


class ComicsListViewModel: MarvelEntityListViewModeling {
    let dataProvider: DataProvider = DataProvider();
    private var list: [MarvelComic] = [];
    var entityList: [MarvelEntityRepresentable] {
        return self.list;
    }
    var queryCondition: String? {
        didSet {
            guard oldValue != queryCondition  else { return; }
            self.page = 1;
            self.list.removeAll();
            self.isRetrieving = false;
            self.request?.cancel();
        }
    }
    
    var entityType: MarvelEntityType {
        return .comics;
    }
    
    private var isRetrieving: Bool = false;
    private var page: Int = 1;
    private var request: DataRequest?;
    
    func retrieveData(_ completion: (([MarvelEntityRepresentable]?) -> Void)?) {
        if self.isRetrieving {
            if let _completion = completion {
                _completion(nil);
            }
            return;
        }
        self.isRetrieving = true;
        let offset: Int = self.itemsPerPage * (self.page-1);
        self.request = self.dataProvider.getEntityList(of: self.entityType, limit: self.itemsPerPage, offset: offset, queryCondition: self.queryCondition) { (result: Result<[MarvelComic]>) in
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
