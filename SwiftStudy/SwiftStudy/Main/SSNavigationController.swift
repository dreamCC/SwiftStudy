//
//  File.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2019/12/22.
//  Copyright © 2019 Zhu ChaoJun. All rights reserved.
//

import Foundation
import UIKit

class SSNavigationController : UINavigationController {

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {

        if self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
}

