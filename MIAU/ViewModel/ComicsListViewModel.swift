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
    
    private var list: [MarvelComic] = [];
    var entityList: [MarvelEntityRepresentable] {
        return self.list;
    }
    
    var itemsPerPage: Int = 100;
    
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
        DataProvider.getEntityList(of: .comics, limit: self.itemsPerPage, offset: offset) { (result: Result<[MarvelComic]>) in
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
