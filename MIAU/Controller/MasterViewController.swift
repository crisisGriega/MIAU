//
//  MasterViewController.swift
//  MIAU
//
//  Created by Gerardo on 27/12/2017.
//  Copyright © 2017 crisisGriega. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel: MasterViewModel = MasterViewModel();
    // Used for cell height calculations
    private let cellViewModel: EntityCellViewModel = EntityCellViewModel();
    
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let reuseId = EntityTableViewCell.reuseIdentifier;
        let nib = UINib.init(nibName: reuseId, bundle: nil);
        self.tableView.register(nib, forCellReuseIdentifier: reuseId);
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
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
}
