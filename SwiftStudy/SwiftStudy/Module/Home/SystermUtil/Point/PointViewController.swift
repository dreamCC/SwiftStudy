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

class PointViewController: SSBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

      
        var age = 10
       
        
        let ptr = withUnsafePointer(to: &age) { $0 }

        let rawPtr = withUnsafePointer(to: &age) { (p) -> UnsafeRawPointer in
            return UnsafeRawPointer(p)
        }
        
        print(ptr, rawPtr, separator: "||")
        
    
        var poe = PoeC()
        print(Mems.ptr(ofRef: poe), Mems.ptr(ofVal: &poe))
        print(withUnsafePointer(to: &poe) { $0 }, UnsafeRawPointer(&poe), UnsafePointer(&poe))
        print(UnsafeRawPointer(bitPattern: unsafeBitCast(poe, to: Int.self)))
    
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


