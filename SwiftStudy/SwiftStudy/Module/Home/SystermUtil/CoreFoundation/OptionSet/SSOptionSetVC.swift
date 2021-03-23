//
//  SSOptionSetVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/1/9.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit

struct SSOptions: OptionSet {
    
    let rawValue: UInt
    
    static let OptionOne = SSOptions(rawValue: 1 << 0)
    static let OptionTwo = SSOptions(rawValue: 1 << 1)

    init(rawValue: UInt) {
        self.rawValue = rawValue
    }
}



class SSOptionSetVC: SSBaseViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 关于OptionSet的使用。 以及OptionSet引入的几个方法，container等。
        
        
    
    
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let options = [SSOptions.OptionOne, SSOptions.OptionTwo]
        
        
        if options.contains(.OptionTwo) {
            print("包含")
        }else {
            print("不包含")
        }
    }
    

}


