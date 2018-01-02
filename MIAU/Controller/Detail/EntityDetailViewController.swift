//
//  EntityDetailViewControllable.swift
//  MIAU
//
//  Created by Gerardo on 01/01/2018.
//  Copyright © 2018 crisisGriega. All rights reserved.
//

import UIKit


class EntityDetailViewController: UIViewController {
    var entityDetailViewModel: EntityDetailViewModel = EntityDetailViewModel();
    
    @IBOutlet weak var tableView: UITableView!;
    @IBOutlet weak var headerView: UIView!;
    @IBOutlet weak var btClose: UIButton!;
    
    var resourceURI: String?;
    
    func styleUIElements() {
        if let theme = Theme.currentTheme {
            self.navigationController?.navigationBar.barTintColor = theme.color(for: "primary") ?? .red;
            let navTintColor = theme.color(for: "sexary") ?? .white;
            self.navigationController?.navigationBar.tintColor = navTintColor;
            self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: navTintColor, .font: theme.textFont(for: "title") ?? UIFont.systemFontSize];
            
            self.headerView.backgroundColor = theme.color(for: "secondary") ?? .black;
            self.tableView.backgroundColor = theme.color(for: "secondary") ?? .black;
            self.view.backgroundColor = theme.color(for: "secondary") ?? .black;
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.styleUIElements();
        self.updateUIElements();
        
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.tableView.register(MarvelListItemCell.self, forCellReuseIdentifier: MarvelListItemCell.reuseIdentifier);
        
        
        self.btClose.isHidden = !(UIDevice.current.userInterfaceIdiom == .pad && self.resourceURI != nil);
        self.btClose.addTarget(self, action: #selector(EntityDetailViewController.onCloseTapped(sender:)), for: .touchUpInside);
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.resizeHeaderToFit()
    }
    
    func resizeHeaderToFit() {
        fatalError("This function should be overridden");
    }
    
    func updateUIElements() {
        fatalError("This function should be overridden");
    }
    
    
    // MARK: Actions
    @objc func onCloseTapped(sender: UIButton) {
        self.dismiss(animated: true, completion: nil);
    }
}


// MARK: UITalbeView DataSource
extension EntityDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.entityDetailViewModel.numberOfSections;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.entityDetailViewModel.numberOfItems(forSection: section);
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MarvelListItemCell.reuseIdentifier, for: indexPath) as! MarvelListItemCell;
        cell.applyStyles();
        cell.item = self.entityDetailViewModel.itemFor(indexPath);
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.entityDetailViewModel.titleForSection(atIndex: section);
    }
}


// MARK: UITableView Delegate
extension EntityDetailViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil);
        
        let item = self.entityDetailViewModel.itemFor(indexPath);
        if let selectedIndexPath = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: selectedIndexPath, animated: false);
        }
        let id: String;
        
        switch item.type {
        case .characters:
            id = String(describing: CharacterDetailViewController.self);
        case .comics:
            id = String(describing: ComicDetailViewController.self);
        case .creators:
            id = String(describing: CreatorDetailViewController.self);
        case .events:
            id = String(describing: EventDetailViewController.self);
        case .series:
            id = String(describing: SerieDetailViewController.self);
        case .stories:
            id = String(describing: StoryDetailViewController.self);
        }
        
        let viewController: UIViewController = storyboard.instantiateViewController(withIdentifier: id);
        (viewController as? EntityDetailViewController)?.resourceURI = item.resourceURI;
        if UIDevice.current.userInterfaceIdiom == .pad {
            // TODO: Shouldn't be opened in a new window if there is already a form opened
            viewController.modalPresentationStyle = .formSheet
            self.present(viewController, animated: true, completion: nil);
        }
        else {
            self.navigationController?.pushViewController(viewController, animated: true);
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        fatalError("This function should be overridden");
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil;
    }
}
