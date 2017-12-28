//
//  MasterViewController.swift
//  MIAU
//
//  Created by Gerardo on 27/12/2017.
//  Copyright © 2017 crisisGriega. All rights reserved.
//

import UIKit
import AKPickerView_Swift


class MasterViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel: MasterViewModel = MasterViewModel();
    // Used for cell height calculations
    private let cellViewModel: EntityCellViewModel = EntityCellViewModel();
    
    private let searchController: UISearchController = UISearchController(searchResultsController: nil);
    
    
    private lazy var picker: AKPickerView = {
        let frame: CGRect = CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 44);
        let picker: AKPickerView = AKPickerView(frame: frame);
        picker.delegate = self;
        picker.dataSource = self;
        
        picker.interitemSpacing = 10.0;
        
        if let theme = Theme.currentTheme {
            picker.backgroundColor = theme.color(for: "secondary") ?? .black;
            picker.textColor = theme.color(for: "tertiary") ?? .white;
            picker.highlightedTextColor = theme.color(for: "sexary") ?? .red;
        }
        
        picker.reloadData();
        
        return picker;
    }();
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up searchController
        self.searchController.searchResultsUpdater = self;
        self.searchController.obscuresBackgroundDuringPresentation = false;
        self.searchController.searchBar.placeholder = "";
        self.searchController.searchBar.scopeButtonTitles = ["Characters", "Comics", "Creators", "Events", "Series", "Stories"];
        self.navigationItem.searchController = self.searchController;
        self.definesPresentationContext = true;
        if let theme = Theme.currentTheme {
            let color = theme.color(for: "sexary");
            self.searchController.searchBar.tintColor = color;
        }
        
        // Set up tableView
        let reuseId = EntityTableViewCell.reuseIdentifier;
        let nib = UINib.init(nibName: reuseId, bundle: nil);
        self.tableView.register(nib, forCellReuseIdentifier: reuseId);
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        if let theme = Theme.currentTheme {
            self.view.backgroundColor = theme.color(for: "secondary");
            self.tableView.backgroundColor = theme.color(for: "secondary");
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        if let theme = Theme.currentTheme {
            self.navigationController?.navigationBar.barTintColor = theme.color(for: "primary");
        }
        
        self.viewModel.retrieveData { (items) in
            self.tableView.reloadData();
        }
    }
}


// MARK: UITableView DataSource
extension MasterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfItems;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EntityTableViewCell.reuseIdentifier, for: indexPath) as! EntityTableViewCell;
        cell.entity = self.viewModel.itemFor(indexPath);
        
        return cell;
    }
}


// MARK: UITableView Delegate
extension MasterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard
            let theme = Theme.currentTheme,
            let titleFont = theme.textFont(for: TextStyle.cellTitle.rawValue),
            let subtitleFont = theme.textFont(for: TextStyle.cellSubtitle.rawValue)  else
        {
            return self.tableView(tableView, estimatedHeightForRowAt: indexPath);
        }
        
        self.cellViewModel.entity = self.viewModel.itemFor(indexPath);
        // TODO: Constant values should be stored somewhere not hardcoded here
        let width: CGFloat = tableView.frame.width - 90.0;
        let titleHeight: CGFloat = ceil(self.cellViewModel.title.heightFor(width: width, font: titleFont));
        let subtitleHeight: CGFloat = ceil(self.cellViewModel.subTitle.heightFor(width: width, font: subtitleFont));
        
        let textHeight = titleHeight + subtitleHeight + 32;
        let estimatedHeight = self.tableView(self.tableView, estimatedHeightForRowAt: indexPath);
        
        return textHeight < estimatedHeight ? estimatedHeight : textHeight;
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0;
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard
            scrollView.contentSize.height > self.viewModel.marginForRetrieving,
            scrollView.contentOffset.y > (scrollView.contentSize.height - self.viewModel.marginForRetrieving) else
        { return; }
        
        let oldItemCount = self.viewModel.numberOfItems;
        self.viewModel.retrieveData({ (items) in
            var indexPaths: [IndexPath] = [];
            for item in oldItemCount..<self.viewModel.numberOfItems {
                indexPaths.append(IndexPath(row: item, section: 0));
            }
            self.tableView.insertRows(at: indexPaths, with: .automatic);
        });
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 0 else { return nil; }
        return self.picker;
    }
}


// MARK: UISearchResultsUpdating
extension MasterViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        // TODO: Retrieve new data
    }
}


// MARK: AKPickerView Delegate
extension MasterViewController: AKPickerViewDelegate {
    func pickerView(_ pickerView: AKPickerView, didSelectItem item: Int) {
        self.viewModel.selectedTypeIndex = item;
    }
}


// MARK: AKPickerView DataSource
extension MasterViewController: AKPickerViewDataSource {
    func numberOfItemsInPickerView(_ pickerView: AKPickerView) -> Int {
        return self.viewModel.numberOfTypes;
    }
    
    func pickerView(_ pickerView: AKPickerView, titleForItem item: Int) -> String {
        return self.viewModel.nameForTypeAtIndex(item);
    }
}
