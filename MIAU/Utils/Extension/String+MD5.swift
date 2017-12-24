//
//  String+MD5.swift
//  MIAU
//
//  Created by Gerardo on 24/12/2017.
//  Copyright © 2017 crisisGriega. All rights reserved.
//

import UIKit

extension String {
    var MD5: String {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        var digest = [UInt8](repeating: 0, count: length)
        
        if let d = self.data(using: String.Encoding.utf8) {
            _ = d.withUnsafeBytes { (body: UnsafePointer<UInt8>) in
                CC_MD5(body, CC_LONG(d.count), &digest)
            }
        }
        
        return (0..<length).reduce("") {
            $0 + String(format: "%02x", digest[$1])
        }
    }
}
