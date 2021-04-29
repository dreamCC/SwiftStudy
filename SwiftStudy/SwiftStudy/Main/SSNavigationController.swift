//
//  File.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2019/12/22.
//  Copyright © 2019 Zhu ChaoJun. All rights reserved.
//

import Foundation
import UIKit

class SSNavigationController : QMUINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigationBar.backIndicatorImage =  UIImage(named: "icon_tabbar_lab_selected")
        
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: true)
        
    }
}

