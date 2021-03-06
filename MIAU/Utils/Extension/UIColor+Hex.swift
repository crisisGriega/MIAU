//
//  UIColor+Hex.swift
//  MIAU
//
//  Created by Gerardo on 28/12/2017.
//  Copyright © 2017 crisisGriega. All rights reserved.
//

import UIKit


extension UIColor {
    /**
     Create a Colour from an hexadecimal code
     */
    convenience init(hex: Int) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }
}

