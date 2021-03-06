//
//  CreatorDetailViewController.swift
//  MIAU
//
//  Created by Gerardo on 01/01/2018.
//  Copyright © 2018 crisisGriega. All rights reserved.
//

import UIKit
import Alamofire

class CreatorDetailViewController: EntityDetailViewController {

    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var btDetail: UIButton!
    
    
    let viewModel: CreatorDetailViewModel = CreatorDetailViewModel();
    override var entityDetailViewModel: EntityDetailViewModel {
        get {
            return self.viewModel as EntityDetailViewModel;
        }
        set {
            
        }
    }
    
    var creator: MarvelCreator? {
        get {
            return self.viewModel.entity as? MarvelCreator;
        }
        set {
            self.viewModel.entity = newValue;
        }
    }
    
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad();
        
        if let uri = resourceURI {
            DataProvider.default.getEntity(of: .comics, withURL: uri, completion: { (result: Result<[MarvelCreator]>) in
                if result.isSuccess {
                    self.creator = result.value?.first;
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
            self.imageView.af_setImage(withURL: url, placeholderImage: #imageLiteral(resourceName: "placeholder-creators"), imageTransition: .crossDissolve(0.2), runImageTransitionIfCached: false);
        }
        self.lbName.text = self.viewModel.name;
        self.lbDescription.text = self.viewModel.description;
        self.btDetail.isHidden = self.viewModel.isDetailHidden;
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let nameEnd: CGFloat = self.lbName.frame.origin.y + self.lbName.frame.size.height;
    self.title = scrollView.contentOffset.y > nameEnd ? self.lbName.text : nil;
    }
}
