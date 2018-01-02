//
//  StoryDetailViewController.swift
//  MIAU
//
//  Created by Gerardo on 01/01/2018.
//  Copyright © 2018 crisisGriega. All rights reserved.
//

import UIKit
import Alamofire


class StoryDetailViewController: EntityDetailViewController {

    @IBOutlet weak var lbType: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var btOriginalIssue: UIButton!
    
    let viewModel: StoryDetailViewModel = StoryDetailViewModel();
    override var entityDetailViewModel: EntityDetailViewModel {
        get {
            return self.viewModel as EntityDetailViewModel;
        }
        set {
            
        }
    }
    
    var story: MarvelStory? {
        get {
            return self.viewModel.entity as? MarvelStory;
        }
        set {
            self.viewModel.entity = newValue;
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        if let uri = resourceURI {
            DataProvider.default.getEntity(of: .comics, withURL: uri, completion: { (result: Result<[MarvelStory]>) in
                if result.isSuccess {
                    self.story = result.value?.first;
                    self.updateUIElements();
                    self.tableView.reloadData();
                    self.view.layoutIfNeeded();
                }
            });
        }
    }
    
    
    // MARK: EntityDetailViewController
    override func resizeHeaderToFit() {
        let headerView = self.tableView.tableHeaderView!;
        var frame = headerView.frame;
        let btFrame = self.btOriginalIssue.frame;
        frame.size.height = btFrame.origin.y + btFrame.size.height + 10;
        
        headerView.frame = frame;
        self.tableView.tableHeaderView = headerView;
    }
    
    override func updateUIElements() {
        self.lbType.text = self.viewModel.type;
        self.lbDescription.text = self.viewModel.description;
        self.btOriginalIssue.isHidden = self.viewModel.isOriginalIssueHidden;
        self.btOriginalIssue.setTitle(self.viewModel.originalIssueTitle, for: .normal);
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let nameEnd: CGFloat = self.lbType.frame.origin.y + self.lbType.frame.size.height;
        self.title = scrollView.contentOffset.y > nameEnd ? self.lbType.text : nil;
    }
}
