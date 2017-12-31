//
//  DetailViewController.swift
//  MIAU
//
//  Created by Gerardo on 31/12/2017.
//  Copyright © 2017 crisisGriega. All rights reserved.
//

import UIKit


class DetailViewController: UIViewController {

    @IBOutlet var characterDetailView: CharacterDetailView!
    
    private var currentView: UIView? {
        didSet {
            guard oldValue != currentView else { return; }
            oldValue?.removeFromSuperview();
            if let newView = self.currentView {
                newView.translatesAutoresizingMaskIntoConstraints = false;
                self.view.addSubview(newView);
                let safeArea = self.view.safeAreaLayoutGuide;
                NSLayoutConstraint.activate([
                    newView.topAnchor.constraint(equalTo: safeArea.topAnchor),
                    newView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
                    newView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
                    newView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
                    ])
            }
        }
    }
    
    var entity: MarvelEntityRepresentable? {
        didSet {
            self.currentView = self.detailView(for: entity);
        }
    }

    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        if let theme = Theme.currentTheme {
            self.navigationController?.navigationBar.tintColor = theme.color(for: "sexary") ?? .white;
            self.view.backgroundColor = theme.color(for: "secondary") ?? .black;
        }
    }
}


// MARK: Private
extension DetailViewController {
    func detailView(for entity: MarvelEntityRepresentable?) -> UIView? {
        guard let type = entity?.type else { return nil; }
        switch type {
            case .characters:
                return self.characterDetailView;
            default:
                return nil;
        }
    }
}
