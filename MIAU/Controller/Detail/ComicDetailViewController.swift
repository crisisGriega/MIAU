//
//  ComicDetailViewController.swift
//  MIAU
//
//  Created by Gerardo on 01/01/2018.
//  Copyright © 2018 crisisGriega. All rights reserved.
//

import UIKit
import Alamofire

class ComicDetailViewController: EntityDetailViewController {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbPages: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var btDetail: UIButton!
    
    
    let viewModel: ComicDetailViewModel = ComicDetailViewModel();
    override var entityDetailViewModel: EntityDetailViewModel {
        get {
            return self.viewModel as EntityDetailViewModel;
        }
        set {
            
        }
    }
    
    var comic: MarvelComic? {
        get {
            return self.viewModel.entity as? MarvelComic;
        }
        set {
            self.viewModel.entity = newValue;
        }
    }
    
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad();
        
        if let uri = resourceURI {
            DataProvider.default.getEntity(of: .comics, withURL: uri, completion: { (result: Result<[MarvelComic]>) in
                if result.isSuccess {
                    self.comic = result.value?.first;
                    self.updateUIElements();
                    self.tableView.reloadData();
                    self.view.layoutIfNeeded();
                }
            });
        }
    }

    
    // MARK: Actions
    @IBAction func onDetailTapped(_ sender: UIButton) {
        guard
            let value: String = self.viewModel.detailURL,
            let url = URL(string: value) else
        {
            return;
        }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil);
    }
    
    
    // MARK: EntityDetailViewController
    override func resizeHeaderToFit() {
        let headerView = self.tableView.tableHeaderView!;
        var frame = headerView.frame;
        let btFrame = self.btDetail.frame;
        frame.size.height = btFrame.origin.y + btFrame.size.height + 10;
        
        headerView.frame = frame;
        self.tableView.tableHeaderView = headerView;
    }
    
    override func updateUIElements() {
        if let url = self.viewModel.imageURL {
            self.imageView.af_setImage(withURL: url, placeholderImage: #imageLiteral(resourceName: "placeholder-comics"), imageTransition: .crossDissolve(0.2), runImageTransitionIfCached: false);
        }
        self.lbTitle.text = self.viewModel.name;
        self.lbDescription.text = self.viewModel.description;
        self.btDetail.isHidden = self.viewModel.isDetailHidden;
        self.lbDate.text = self.viewModel.date;
        self.lbPrice.isHidden = self.viewModel.isPriceHidden;
        self.lbPrice.text = self.viewModel.price;
        self.lbPages.isHidden = self.viewModel.isPagesHidden;
        self.lbPages.text = self.viewModel.pages;
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let nameEnd: CGFloat = self.lbTitle.frame.origin.y + self.lbTitle.frame.size.height;
        self.title = scrollView.contentOffset.y > nameEnd ? self.lbTitle.text : nil;
    }
}
