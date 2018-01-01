//
//  MarvelListItemCell.swift
//  MIAU
//
//  Created by Gerardo on 01/01/2018.
//  Copyright © 2018 crisisGriega. All rights reserved.
//

import UIKit

class MarvelListItemCell: UITableViewCell {

    private let viewModel: MarvelListItemCellViewModel = MarvelListItemCellViewModel();
    
    var item: MarvelItemListable? {
        get {
            return self.viewModel.item;
        }
        set {
            self.viewModel.item = newValue
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if let theme = Theme.currentTheme {
            self.backgroundColor = theme.color(for: "tertiary");
            self.textLabel?.style = "title";
            self.detailTextLabel?.style = "subtitle";
//            self.textLabel?.textColor = theme.color(for: "sexary");
//            self.detailTextLabel?.textColor = theme.color(for: "sexary");
        }
    }
}


// MARK: Private
private extension MarvelListItemCell {
    func updateUI() {
        self.textLabel?.text = self.viewModel.name;
        self.detailTextLabel?.text = self.viewModel.detail;
    }
}
