//
//  AppDelegate+extension.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2019/12/22.
//  Copyright © 2019 Zhu ChaoJun. All rights reserved.
//

import Foundation
import UIKit

extension AppDelegate {
    
    func initAppUI() {
        
        let tab = SSTabBarController()

        window?.backgroundColor = UIColor.white
        window?.rootViewController = tab
        window?.makeKeyAndVisible()
    }
}
