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


class PoeC {
    var age: Int = 0
    
}

var all = 10


class PointViewController: SSBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
        var age = 10
       
        var poe = PoeC()
        print(Mems.ptr(ofRef: poe), Mems.ptr(ofVal: &poe))
        print(Mems.ptr(ofVal: &age))
    
        var poeType = PoeC.self
        print(Mems.ptr(ofVal: &poeType), Mems.ptr(ofRef: poeType))
        print(Mems.ptr(ofVal: &all))
        
       

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


