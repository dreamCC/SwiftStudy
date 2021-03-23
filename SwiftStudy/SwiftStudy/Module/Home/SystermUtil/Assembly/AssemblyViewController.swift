//
//  AssemblyViewController.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2021/3/2.
//  Copyright © 2021 Zhu ChaoJun. All rights reserved.
//

import UIKit

class AssemblyViewController: SSBaseViewController {

    enum Spring: Int {
        case one, two, three
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        var a = Spring.one
        
    
        a = .two
        a = .three
        
        print(a)
        
        
    }
    


}



