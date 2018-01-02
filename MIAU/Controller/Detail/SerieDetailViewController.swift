//
//  SerieDetailViewController.swift
//  MIAU
//
//  Created by Gerardo on 01/01/2018.
//  Copyright © 2018 crisisGriega. All rights reserved.
//

import UIKit

class SerieDetailViewController: EntityDetailViewController {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var lbPeriod: UILabel!
    @IBOutlet weak var btPrevious: UIButton!
    @IBOutlet weak var btNext: UIButton!
    @IBOutlet weak var btDetail: UIButton!
    
    let viewModel: SerieDetailViewModel = SerieDetailViewModel();
    override var entityDetailViewModel: EntityDetailViewModel {
        get {
            return self.viewModel as EntityDetailViewModel;
        }
        set {
            
        }
    }
    
    var serie: MarvelSerie? {
        get {
            return self.viewModel.entity as? MarvelSerie;
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
        let stackFrame = self.btDetail.frame;
        frame.size.height = stackFrame.origin.y + stackFrame.size.height + 10;
        
        headerView.frame = frame;
        self.tableView.tableHeaderView = headerView;
    }
    
    override func updateUIElements() {
        if let url = self.viewModel.imageURL {
            self.imageView.af_setImage(withURL: url, placeholderImage: #imageLiteral(resourceName: "placeholder-series"), imageTransition: .crossDissolve(0.2), runImageTransitionIfCached: false);
        }
        self.lbTitle.text = self.viewModel.title;
        self.lbDescription.text = self.viewModel.description;
        self.lbPeriod.text = self.viewModel.period;
        self.btDetail.isHidden = self.viewModel.isDetailHidden;
        self.btPrevious.isHidden = self.viewModel.isPreviousHidden;
        self.btPrevious.setTitle(self.viewModel.previousName, for: .normal);
        self.btNext.isHidden = self.viewModel.isNextHidden;
        self.btNext.setTitle(self.viewModel.nextName, for: .normal);
    }
    
    
    // MARK: Actions
    @IBAction func onDetailTapped(_ sender: UIButton) {
        guard let value: String = self.viewModel.detailURL,
            let url: URL = URL(string: value) else
        {
            return;
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil);
    }
}


// MARK: UITableView Delegate
extension SerieDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: Open a new page passing the resource URI
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let nameEnd: CGFloat = self.lbTitle.frame.origin.y + self.lbTitle.frame.size.height;
        self.title = scrollView.contentOffset.y > nameEnd ? self.lbTitle.text : nil;
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil;
    }
}
