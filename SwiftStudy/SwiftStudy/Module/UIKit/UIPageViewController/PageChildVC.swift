//
//  PageChildVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/11/2.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit

class PageChildVC: SSBaseViewController {

    private var value: String!
    
    convenience init(value: String) {
        self.init(nibName: nil, bundle: nil)
        self.value = value
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("viewDidLoad: ", self.description)
    
        desLab.text = value + self.description
        view.backgroundColor = UIColor.qmui_random()
    }

   
}
