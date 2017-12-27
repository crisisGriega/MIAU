//
//  EntityTableViewCell.swift
//  MIAU
//
//  Created by Gerardo on 27/12/2017.
//  Copyright © 2017 crisisGriega. All rights reserved.
//

import UIKit

class EntityTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbSubtitle: UILabel!
    
    private let viewModel: EntityCellViewModel = EntityCellViewModel();
    
    var entity: MarvelEntityRepresentable? {
        get {
            return self.viewModel.entity;
        }
        set {
            self.viewModel.entity = newValue;
            self.updateUI();
        }
    }
    
    
    // MARK: Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}


// MARK: Private
private extension EntityTableViewCell {
    func updateUI() {
        self.lbTitle.text = self.viewModel.title;
        self.lbTitle.sizeToFit();
        self.lbSubtitle.text = self.viewModel.subTitle;
        self.lbTitle.sizeToFit();
    }
}
