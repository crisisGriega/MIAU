//
//  CharacterDetailViewController.swift
//  MIAU
//
//  Created by Gerardo on 31/12/2017.
//  Copyright © 2017 crisisGriega. All rights reserved.
//

import UIKit

class CharacterDetailViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var btDetail: UIButton!
    @IBOutlet weak var btWiki: UIButton!
    @IBOutlet weak var btComicLink: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lcTableViewHeight: NSLayoutConstraint!
    
    let viewModel: CharacterDetailViewModel = CharacterDetailViewModel();
    
    var character: MarvelCharacter? {
        get {
            return self.viewModel.character;
        }
        set {
            self.viewModel.character = newValue;
        }
    }
    
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.styleUIElements();
        self.updateUIElements();
        self.tableView.dataSource = self;
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


// MARK: UITableView DataSource
extension CharacterDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.numberOfSections;
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfItems(forSection: section);
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MarvelListItemCell.reuseIdentifier, for: indexPath) as! MarvelListItemCell;
        cell.item = self.viewModel.itemFor(indexPath);
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.viewModel.titleForSection(atIndex: section);
    }
}

// MARK: Private
private extension CharacterDetailViewController {
    func styleUIElements() {
        if let theme = Theme.currentTheme {
            self.navigationController?.navigationBar.barTintColor = theme.color(for: "primary") ?? .red;
            self.navigationController?.navigationBar.tintColor = theme.color(for: "sexary") ?? .white;
            
            self.scrollView.backgroundColor = theme.color(for: "secondary") ?? .black;
            self.view.backgroundColor = theme.color(for: "secondary") ?? .black;
        }
    }
    
    func updateUIElements() {
        if let url = self.viewModel.imageURL {
            self.imageView.af_setImage(withURL: url, placeholderImage: #imageLiteral(resourceName: "placeholder-characters"), imageTransition: .crossDissolve(0.2), runImageTransitionIfCached: false);
        }
        self.lbName.text = self.viewModel.name;
        self.lbDescription.text = self.viewModel.description;
        self.btDetail.isHidden = self.viewModel.isDetailHidden;
        self.btWiki.isHidden = self.viewModel.isWikiHidden;
        self.btComicLink.isHidden = self.viewModel.isComicLinkHidden;
        
        var size = self.scrollView.contentSize;
        size.height = self.tableView.frame.origin.y + self.tableView.frame.height;
        self.scrollView.contentSize = size;
    }
}
