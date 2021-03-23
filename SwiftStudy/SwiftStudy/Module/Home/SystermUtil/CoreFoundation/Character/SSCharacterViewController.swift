//
//  SSCharacterViewController.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/11/2.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit

class SSCharacterViewController: SSBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        titleName = "Character"
        
        desLab.text = "Character表示一个字符，也可以是unicode字符。 和String类型的区别。 CharacterSet 表示的是一组字符串。"
        

        let a = Character("a")

        print(a.isNumber, a.isLetter, a.isEmoji)
    }
}


extension Character {
    
    var string: String {
        return String(self)
    }
    
    var isEmoji: Bool {
        guard  let scalarValue = string.unicodeScalars.first?.value else {
            return false
        }
        
        switch scalarValue {
        case 0x3030, 0x00AE, 0x00A9, // Special Character > 特殊字符
             0x1D000...0x1F77F,      // Emoticons > 情感符
             0x2100...0x27BF, // Misc symbols and Dingbats >
             0xFE00...0xFE0F, // Variation Selectors > 变异选择符
             0x1F900...0x1F9FF: // Supplemental Symbols and Pictographs > 补充的符号和象形文字
        return true
        default:
            return false
        }
    }
    
    var isNumber: Bool {
        let intValue = Int(string)
        if intValue == nil {
            return false
        }else {
            return true
        }
    }
    
    var isLetter: Bool {
       return string.rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
    }
    
    var isLowercased: Bool {
        return string == string.lowercased()
    }
    
    var isUppercased: Bool {
        return string == string.uppercased()
    }
    
    var isWhiteSpace: Bool {
        return string == " "
    }
    
    var int: Int? {
        return Int(string)
    }
    
    var lowercased: Character {
        return string.lowercased().first!
    }
       
   var uppercased: Character {
        return string.uppercased().first!
  }
}
