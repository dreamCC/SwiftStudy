//
//  RegexUtil.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2021/1/4.
//  Copyright © 2021 Zhu ChaoJun. All rights reserved.
//

import UIKit

class RegexUtil {
    
    static func isPhone(_ phone: String) -> Bool{
        let regex = "^1[3|4|5|7|8][0-9]{9}$"
        let predicat = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicat.evaluate(with: phone)
    }

    static func isPwd(_ pwd: String) -> Bool {
        let regex = "[0-9]{4}"
        let predicat = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicat.evaluate(with: pwd)
    }
}
