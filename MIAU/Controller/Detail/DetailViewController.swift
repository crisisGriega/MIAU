//
//  DetailViewController.swift
//  MIAU
//
//  Created by Gerardo on 31/12/2017.
//  Copyright © 2017 crisisGriega. All rights reserved.
//

import UIKit


class DetailViewController: UIViewController {

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        if let theme = Theme.currentTheme {
            self.navigationController?.navigationBar.tintColor = theme.color(for: "sexary") ?? .white;
            self.view.backgroundColor = theme.color(for: "secondary") ?? .black;
        }
    }
}

