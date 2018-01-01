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
        self.tableView.register(MarvelListItemCell.self, forCellReuseIdentifier: MarvelListItemCell.reuseIdentifier);
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
}

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
