//
//  Poe.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2021/4/21.
//  Copyright © 2021 Zhu ChaoJun. All rights reserved.
//

import UIKit

struct Poe<Base> {
    private let base: Base
    init(_ base: Base) {
        self.base = base
    }
}


protocol PoCompitable {}
extension PoCompitable {
    var po: Poe<Self> { Poe(self) }
}

extension String: PoCompitable {}
extension Poe where Base == String {
    var json: Json { return Json(self) }
}





