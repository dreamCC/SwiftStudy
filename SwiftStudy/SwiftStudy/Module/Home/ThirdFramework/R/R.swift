//
//  R.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2021/4/16.
//  Copyright © 2021 Zhu ChaoJun. All rights reserved.
//

import UIKit


// 资源管理的思路。。。。。
//enum R {
//    enum PImage: String {
//        case logo
//    }
//
//    enum Ptring: String {
//        case logo
//    }
//}

//extension UIImage {
//    
//    // 增加便利构造器
//    convenience init?(_ r: R.PImage) {
//        self.init(named: r.rawValue)
//    }
//}

//enum R {
//    enum image {
//        static func logo() -> UIImage?{
//            return UIImage(named: "logo.png")
//        }
//    }
//}


extension UIImage {
    
    enum Home {
        static var logoImage: UIImage? {
            UIImage(named: "red")
        }
    }
    
    
    
    
}
