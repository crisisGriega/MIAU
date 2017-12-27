//
//  UITableViewCell+reuseIdentifier.swift
//  MIAU
//
//  Created by Gerardo on 27/12/2017.
//  Copyright © 2017 crisisGriega. All rights reserved.
//

import UIKit


extension UITableViewCell {
    public static var reuseIdentifier: String {
        return String(describing: self);
    }
}
