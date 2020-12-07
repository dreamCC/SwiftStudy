//
//  SSClassAndStructVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/12/2.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit
/*
 理解class和struct
 
 
 */
class SSClassAndStructVC: SSBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cls = MineClass()
        
        let stu = MineStruct()
    }
    
}


class MineClass {
    
    var name: String?
    
    deinit {
        
    }
}


struct MineStruct {
    
    var name: String?
    
   
}



