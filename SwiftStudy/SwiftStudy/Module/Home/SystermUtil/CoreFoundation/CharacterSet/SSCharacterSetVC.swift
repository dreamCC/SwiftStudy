//
//  SSCharacterSetVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2019/12/26.
//  Copyright © 2019 Zhu ChaoJun. All rights reserved.
//

import UIKit

/*
 
 CharacterSet.alphanumerics    字母和数字的组合，包含大小写, 不包含小数点
 CharacterSet.capitalizedLetters    字母，首字母大写，Lt类别
 CharacterSet.decimalDigits    0-9的数字，也不包含小数点
 CharacterSet.whitespaces    空格
 CharacterSet.whitespacesAndNewlines    空格和换行
 CharacterSet.letters    所有英文字母，包含大小写 65-90 97-122
 CharacterSet.lowercaseLetters    小写英文字母 97-122
 CharacterSet.uppercaseLetters    大写英文字母 65-90
 CharacterSet.nonBaseCharacters    非基础字符 M*
 CharacterSet.illegalCharacters    不合规字符，没有在Unicode 3.2 标准中定义的字符
 CharacterSet.punctuationCharacters    标点符号，连接线，引号什么的 P*
 CharacterSet.symbols    符号，包含S* 所有内容，运算符，货币符号什么的
 CharacterSet.newlines    返回一个包含换行符的字符集，U+000A ~ U+000D, U+0085, U+2028, and U+2029
 CharacterSet.symbols    符号，包含S* 所有内容，运算符，货币符号什么的
 inverted    相反的字符集。例如CharacterSet.whitespaces.inverted 就是没有空格
 
 */
class SSCharacterSetVC: SSBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.titleName = "CharacterSet"
        self.desLab.text = "CharacterSet，在swift中是结构体，在oc中，是对象。其实就是用来表示一组Unicode字符。经常配合String来进行一些查找或者删除的功能。"
        
        characterSetFunc()
        
    
    }
    
    func characterSetFunc() {
        
        let trim = "  嗯   哈 "
        let newVar = trim.trimmingCharacters(in: CharacterSet.whitespaces)
        print(newVar)
    }

}
