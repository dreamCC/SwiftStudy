//
//  PointViewController.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2021/3/3.
//  Copyright © 2021 Zhu ChaoJun. All rights reserved.
//

import UIKit
import Alamofire
import Moya


struct Poe<Base> {
   private let base: Base
    init(_ base: Base) {
        self.base = base
    }
}

protocol PoeNameComposible {
    associatedtype composible
    var rx: composible {get}
}

extension PoeNameComposible {
    var rx
}


class PointViewController: SSBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

      
        var age = 10
       
        
        let ptr = withUnsafePointer(to: &age) { $0 }

        let rawPtr = withUnsafePointer(to: &age) { (p) -> UnsafeRawPointer in
            return UnsafeRawPointer(p)
        }
        
        print(ptr, rawPtr.load(as: UTF8.self), separator: "||")
        
        
    }
    
    
    func _unsafePointer<T>(to value: inout T) -> String {
        
        // 这两种写法是一样的。
        let ptr = withUnsafePointer(to: value) { $0 }
        
//        let ptr = withUnsafePointer(to: &age) { (p) -> UnsafePointer<Int> in
//            return p
//        }
        
    
        return ptr.debugDescription
    }


}


