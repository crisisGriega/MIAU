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
            self.viewModel.item = newValue;
            self.updateUI();
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.applyStyles();
    }
    
    func applyStyles() {
        if let theme = Theme.currentTheme {
            self.backgroundColor = theme.color(for: "tertiary");
            self.textLabel?.style = "title";
            self.detailTextLabel?.style = "subtitle";
            
            let backgroundView = UIView();
            backgroundView.backgroundColor = theme.color(for: "secondary");
            self.selectedBackgroundView = backgroundView;
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
