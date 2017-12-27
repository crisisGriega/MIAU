//
//  CustomSplitViewController.swift
//  MIAU
//
//  Created by Gerardo on 27/12/2017.
//  Copyright © 2017 crisisGriega. All rights reserved.
//

import UIKit

class CustomSplitViewController: UISplitViewController {
    
    override func viewDidLoad() {
        self.delegate = self;
        self.preferredDisplayMode = .allVisible;
    }
}

extension CustomSplitViewController: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        // Return true to prevent UIKit from applying its default behavior
        return true;
    }
}
