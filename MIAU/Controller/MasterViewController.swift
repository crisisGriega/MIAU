//
//  MasterViewController.swift
//  MIAU
//
//  Created by Gerardo on 27/12/2017.
//  Copyright © 2017 crisisGriega. All rights reserved.
//

import UIKit
import AKPickerView_Swift
import DSGradientProgressView


enum SegueId: String {
    case charactersDetail = "show-characters-detail";
    case comicsDetail = "show-comics-detail";
    case creatorsDetail = "show-creators-detail";
    case eventsDetail = "show-events-detail";
    case seriesDetail = "show-series-detail";
    case storiesDetail = "show-stories-detail";
}

class MasterViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var progressView: DSGradientProgressView!
    
    private let viewModel: MasterViewModel = MasterViewModel();
    private var reloadWorkItem: DispatchWorkItem?
    // Used for cell height calculations
    private let cellViewModel: EntityCellViewModel = EntityCellViewModel();
    
    private let searchController: UISearchController = UISearchController(searchResultsController: nil);
    
    private lazy var picker: AKPickerView = {
        var frame: CGRect = CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 30);
        let picker: AKPickerView = AKPickerView(frame: frame);
        picker.delegate = self;
        picker.dataSource = self;
        
        picker.interitemSpacing = 10.0;
        
        picker.reloadData();
        
        return picker;
    }();
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.setUpSearechController();
        self.setUpTableView();
        
        self.styleUIElements();
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        
        self.retrieveData();
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let identifier = segue.identifier,
            let _segueId = SegueId(rawValue: identifier),
            let selectedIndexPath = self.tableView.indexPathForSelectedRow else
        {
                return;
        }
        
        switch _segueId {
            case .charactersDetail:
                guard let destination = segue.destination as? CharacterDetailViewController else { return; }
                destination.character = self.viewModel.itemFor(selectedIndexPath) as? MarvelCharacter;
            case .comicsDetail:
                guard let destination = segue.destination as? ComicDetailViewController else { return; }
                destination.comic = self.viewModel.itemFor(selectedIndexPath) as? MarvelComic;
            case .creatorsDetail:
                guard let destination = segue.destination as? CreatorDetailViewController else { return; }
                // TODO: assign creator
            case .eventsDetail:
                guard let destination = segue.destination as? EventDetailViewController else { return; }
                // TODO: assign event
            case .seriesDetail:
                guard let destination = segue.destination as? SerieDetailViewController else { return; }
                // TODO: assign serie
            case .storiesDetail:
                guard let destination = segue.destination as? StoryDetailViewController else { return; }
                destination.story = self.viewModel.itemFor(selectedIndexPath) as? MarvelStory;
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let segueIdentifier: String = "show-\(self.viewModel.selectedType)-detail";
        self.performSegue(withIdentifier: segueIdentifier, sender: nil);
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard
            let theme = Theme.currentTheme,
            let titleFont = theme.textFont(for: TextStyle.title.rawValue),
            let subtitleFont = theme.textFont(for: TextStyle.subtitle.rawValue)  else
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
        self.progressView.wait();
        self.viewModel.retrieveData({ (items) in
            defer { self.progressView.signal(); }
            guard items != nil else { return; }
            
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
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil;
    }
}


// MARK: UISearchResultsUpdating
extension MasterViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return; }
        
        let value = !searchText.isEmpty ? searchText : nil;
        self.viewModel.queryCondition = value;
        self.tableView.reloadData();
        
        self.reloadWorkItem?.cancel();
        self.reloadWorkItem = DispatchWorkItem { [weak self] in
            self?.retrieveData();
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500), execute: self.reloadWorkItem!);
    }
}


// MARK: AKPickerView Delegate
extension MasterViewController: AKPickerViewDelegate {
    func pickerView(_ pickerView: AKPickerView, didSelectItem item: Int) {
        self.viewModel.selectedTypeIndex = item;
        self.searchController.searchBar.isUserInteractionEnabled = self.viewModel.isSearchable;
        if !self.viewModel.isSearchable { self.searchController.isActive = false; }
        
        self.tableView.reloadData();
        self.reloadWorkItem?.cancel();
        self.reloadWorkItem = DispatchWorkItem { [weak self] in
            if self?.viewModel.numberOfItems == 0 {
                self?.retrieveData();
            }
            else {
                self?.tableView.reloadData();
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500), execute: self.reloadWorkItem!);
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


// MARK: Private
private extension MasterViewController {
    func retrieveData() {
        self.progressView.wait();
        self.viewModel.retrieveData { (items) in
            self.tableView.reloadData();
            self.progressView.signal();
        }
    }
    
    func setUpSearechController() {
        self.searchController.searchResultsUpdater = self;
        self.searchController.obscuresBackgroundDuringPresentation = false;
        self.searchController.searchBar.placeholder = "";
        
        self.navigationItem.searchController = self.searchController;
        self.definesPresentationContext = true;
    }
    
    func setUpTableView() {
        let reuseId = EntityTableViewCell.reuseIdentifier;
        let nib = UINib.init(nibName: reuseId, bundle: nil);
        self.tableView.register(nib, forCellReuseIdentifier: reuseId);
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
    }
    
    func styleUIElements() {
        guard let theme = Theme.currentTheme else { return; }
        self.navigationController?.navigationBar.barTintColor = theme.color(for: "primary");
        self.searchController.searchBar.tintColor = theme.color(for: "sexary") ?? .white;
        
        self.view.backgroundColor = theme.color(for: "secondary");
        
        self.tableView.backgroundColor = theme.color(for: "secondary");
        
        self.picker.backgroundColor = theme.color(for: "secondary") ?? .black;
        self.picker.textColor = theme.color(for: "tertiary") ?? .white;
        self.picker.highlightedTextColor = theme.color(for: "sexary") ?? .red;
        
        
        
        self.progressView.backgroundColor = theme.color(for: "secondary") ?? .red;
        self.progressView.barColor = theme.color(for: "quinary") ?? .red;
    }
}
