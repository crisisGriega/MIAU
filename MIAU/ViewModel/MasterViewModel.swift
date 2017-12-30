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
    private let characterListViewModel: CharactersListViewModel = CharactersListViewModel();
    private let comicListViewModel: ComicsListViewModel = ComicsListViewModel();
    private var currentViewModel: MarvelEntityListViewModeling!
    
    init(with selectedType: MarvelEntityType = .characters) {
        self.currentViewModel = self.entityListViewModel(for: selectedType);
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
            if oldValue == self.selectedTypeIndex { return; }
            self.currentViewModel = self.entityListViewModel(for: self.selectedTypeIndex);
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


// MARK: Private
private extension MasterViewModel {
    func entityListViewModel(for entityType: MarvelEntityType) -> MarvelEntityListViewModeling {
        switch entityType {
            case .characters:
                return self.characterListViewModel;
            case .comics:
                return self.comicListViewModel;
            default:
                return self.characterListViewModel;
        }
    }
    
    func entityListViewModel(for index: Int) -> MarvelEntityListViewModeling {
        return self.entityListViewModel(for: self.entityTypes[index]);
    }
}
