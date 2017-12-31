//
//  MasterViewModel.swift
//  MIAU
//
//  Created by Gerardo on 27/12/2017.
//  Copyright © 2017 crisisGriega. All rights reserved.
//

import UIKit


class MasterViewModel {
    
    private let entityTypes: [MarvelEntityType] = [.characters, .comics, .creators, .events, .series, .stories];
    private let viewModels: [MarvelEntityListViewModeling] = [
        MarvelEntityListViewModel<MarvelCharacter>(entityType: .characters),
        MarvelEntityListViewModel<MarvelComic>(entityType: .comics),
        MarvelEntityListViewModel<MarvelCreator>(entityType: .creators),
        MarvelEntityListViewModel<MarvelEvent>(entityType: .events),
        MarvelEntityListViewModel<MarvelSerie>(entityType: .series),
        MarvelEntityListViewModel<MarvelStory>(entityType: .stories)];
    
    private var currentViewModel: MarvelEntityListViewModeling!
    
    init(with selectedType: MarvelEntityType = .characters) {
        self.currentViewModel = self.viewModels[self.selectedTypeIndex];
    }
    
    var isSearchable: Bool {
        return self.entityTypes[self.selectedTypeIndex] != .stories;
    }
    
    var queryCondition: String? = nil {
        didSet {
            guard oldValue != queryCondition  else { return; }
            self.currentViewModel.queryCondition = queryCondition;
        }
    }
    
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
            guard oldValue != self.selectedTypeIndex else { return; }
            self.currentViewModel = self.viewModels[self.selectedTypeIndex];
            self.currentViewModel.queryCondition = self.queryCondition;
        }
    }
    
    // List
    var numberOfItems: Int {
        return self.currentViewModel.numberOfItems
    }
    
    var marginForRetrieving: CGFloat {
        return (self.cellHeight) * CGFloat(self.currentViewModel.itemsPerPage / 2);
    }
    
    var cellHeight: CGFloat {
        return 60.0;
    }
    
    func itemFor(_ indexPath: IndexPath) -> MarvelEntityRepresentable? {
        return self.currentViewModel.itemFor(indexPath);
    }
    
    func retrieveData(_ completion: (([MarvelEntityRepresentable]?) -> Void)?) {
        self.currentViewModel.retrieveData(completion);
    }
}
