//
//  R.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2021/4/16.
//  Copyright © 2021 Zhu ChaoJun. All rights reserved.
//

import UIKit

enum R {
    enum PImage: String {
        case logo
    }
    
    enum Ptring: String {
        case logo
    }
}

extension UIImage {
    
    // 增加便利构造器
    convenience init?(_ r: R.PImage) {
        self.init(named: r.rawValue)
    }
}
