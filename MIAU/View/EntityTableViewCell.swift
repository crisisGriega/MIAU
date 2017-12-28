//
//  EntityTableViewCell.swift
//  MIAU
//
//  Created by Gerardo on 27/12/2017.
//  Copyright © 2017 crisisGriega. All rights reserved.
//

import UIKit
import AlamofireImage

class EntityTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbSubtitle: UILabel!
    @IBOutlet weak var imgSpinner: UIActivityIndicatorView!
    
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
        self.separatorInset = .zero;
        
        if let theme = Theme.currentTheme {
            self.contentView.backgroundColor = theme.color(for: "tertiary");
            let backgroundView = UIView();
            backgroundView.backgroundColor = theme.color(for: "secondary");
            self.selectedBackgroundView = backgroundView;
        }
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
        self.imgView.af_cancelImageRequest();
        self.imgView.image = self.viewModel.imagePlaceholder;
        if let url = self.viewModel.imageURL {
            self.imgSpinner.startAnimating();
            self.imgView.af_setImage(withURL: url, placeholderImage: self.viewModel.imagePlaceholder, imageTransition: .crossDissolve(0.2), runImageTransitionIfCached: false, completion: { (image) in
                self.imgSpinner.stopAnimating();
            })
        }
    }
}
