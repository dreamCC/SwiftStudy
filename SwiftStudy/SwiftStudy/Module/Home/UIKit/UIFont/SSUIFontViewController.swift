//
//  SSUIFontViewController.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/11/3.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit

class SSUIFontViewController: SSBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 所有的字体
        let fontFamliy = UIFont.familyNames
        print(fontFamliy.count, fontFamliy.first)
        
        //desLab.font = UIFont.italicSystemFont(ofSize: 20)
        
        //desLab.text = "这是斜体"
        
        // 同样我们可以添加字体文件 xxx.ttf
        // 然后在plist中配置。
        
        // 动态字体。 前提是：adjustsFontForContentSizeCategory需要打开。
        //desLab.font = UIFont.preferredFont(forTextStyle: .headline)
        desLab.font = UIFont.preferredFont(forTextStyle: .body)
        //desLab.font = UIFont.preferredFont(forTextStyle: .body, compatibleWith: self.traitCollection)
        desLab.adjustsFontForContentSizeCategory = true
        desLab.text = "标题，子标题，正文等等都是一些比较朴素。 我感觉这也就相当于word中的“样式”，把自己的每个章节的标题子标题选中设置成标题一或者标题二 然后就能用word的自动生成目录功能，并且一改某个样式里详细设置，每个标题子标题的格式也都会随之改变。 这里就是如果你在代码中把字体用这些样式，那你在手机setting里设置大小之后应用字体会有所反应。"
        
        // UIFontDescriptor 用来显示字体
        let font = UIFont.preferredFont(forTextStyle: .body)
        let fontDes = font.fontDescriptor
        print(fontDes.description)
        
       
    }

}
