//
//  CharacterDetailViewController.swift
//  MIAU
//
//  Created by Gerardo on 31/12/2017.
//  Copyright © 2017 crisisGriega. All rights reserved.
//

import UIKit

class CharacterDetailViewController: EntityDetailViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var urlStackView: UIStackView!
    @IBOutlet weak var btDetail: UIButton!
    @IBOutlet weak var btWiki: UIButton!
    @IBOutlet weak var btComicLink: UIButton!
    
    let viewModel: CharacterDetailViewModel = CharacterDetailViewModel();
    override var entityDetailViewModel: EntityDetailViewModel {
        get {
            return self.viewModel as EntityDetailViewModel;
        }
        set {
            
        }
    }
    
    var character: MarvelCharacter? {
        get {
            return self.viewModel.entity as? MarvelCharacter;
        }
        set {
            self.viewModel.entity = newValue;
        }
    }
    
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad();
        self.tableView.delegate = self;
    }
    
    
    // MARK: EntityDetailViewController
    override func resizeHeaderToFit() {
        let headerView = self.tableView.tableHeaderView!;
        var frame = headerView.frame;
        let stackFrame = self.urlStackView.frame;
        frame.size.height = stackFrame.origin.y + stackFrame.size.height + 10;
        
        headerView.frame = frame;
        self.tableView.tableHeaderView = headerView;
    }
    
    override func updateUIElements() {
        if let url = self.viewModel.imageURL {
            self.imageView.af_setImage(withURL: url, placeholderImage: #imageLiteral(resourceName: "placeholder-characters"), imageTransition: .crossDissolve(0.2), runImageTransitionIfCached: false);
        }
        self.lbName.text = self.viewModel.name;
        self.lbDescription.text = self.viewModel.description;
        self.btDetail.isHidden = self.viewModel.isDetailHidden;
        self.btWiki.isHidden = self.viewModel.isWikiHidden;
        self.btComicLink.isHidden = self.viewModel.isComicLinkHidden;
    }
    
    
    // MARK: Actions
    @IBAction func moreInfoButtonTapped(_ sender: UIButton) {
        var url: String? = nil;
        
        if sender == self.btDetail {
            url = self.viewModel.detailURL;
        }
        else if sender == self.btWiki {
            url = self.viewModel.wikiURL;
        }
        else if sender == self.btComicLink {
            url = self.viewModel.comicLinkURL;
        }
        
        
        if let value: String = url, let _url: URL = URL(string: value) {
            UIApplication.shared.open(_url, options: [:], completionHandler: nil);
        }
    }
}


// MARK: UITableView Delegate
extension CharacterDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: Open a new page passing the resource URI
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let nameEnd: CGFloat = self.lbName.frame.origin.y + self.lbName.frame.size.height;
        self.title = scrollView.contentOffset.y > nameEnd ? self.lbName.text : nil;
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil;
    }
}
