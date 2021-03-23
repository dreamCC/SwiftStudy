//
//  SSStringVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2019/12/23.
//  Copyright © 2019 Zhu ChaoJun. All rights reserved.
//

import UIKit
import SnapKit


class SSStringVC: UIViewController {

    
    lazy var name: String = {
        print("懒加载")
        return "enha"
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "String"
        view.backgroundColor = UIColor.white
        
        
        let desLab = UITextView()
        desLab.font = UIFont.systemFont(ofSize: 16)
        desLab.text = "Swift中String是结构体。并不像oc中是对象。这样设计很好，因为会避免引用类型引起的通病（比如oc中我们对NSString进行传递的时候，经常使用copy等关键字可能就是这个原因），Swift中的字符串更像是字符数组。\n\n1、通过+或者\\()，或者append来进行拼接。\n2、str.count字符串长度。\n3、for charact in str {} 字符串遍历。\n3、str.uppercased()和str.lowercased() 大小写转换。\n4、str.prefix 、str.suffix获取前后缀。通过str[String.Index(可省略)...String.Index]这种区间写法进行截取，字符串截取后，获取的其实是SubString结构体，而且我们特别需要关注SubString和String直接的关系。一般语言字符串截取后都是新开辟一块内存存放subString，而Swift对此进行了优化，截取后就是SubString类型。会和BaseString共用内存，可以理解为BaseString和Range构成。这就意味着，如果SubStirng不销毁那么baseString也不会销毁，当然我们直接通过String(SubString)就能将SubString转换为String。subString这种写法已近被遗弃。\n5、String.Index其实Index是String的内部结构体。常永刚的方法str.startIndex、str.endIndex、str.index(xx, offBy: xx)、str.index(xx， offBy:xx limited：xxx)。\n6、StringProtocol其实抽象了String的功能方法。比如上面的方法都是StirngProtocol中。而且Stirng和SubString都是遵循该协议的。我们可以合理的利用该协议作为参数。\n7、isEmpty来确定String的长度是否为空，前提是String类型。\n7、Swift4.0之后，String和OC中的NSStirng可以实现无缝桥接。也就是String可以使用NSString的方法。\n8、Swift的原生字符串类型被编译成Unicode标量，这就导致了String中每个Character的长度并不一样。这也是Swift引入Stirng.Index的原因。如果使用固定Int类型来表示显然不合理。如上所述，不同的字符可能由不同大小的内存来存储，因此为了确定字符所在的位置，必须从该字符串的开始或结尾对每个Unicode标量进行遍历。因此，Swift字符串不能被整数值索引。"
        view.addSubview(desLab)
        desLab.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(10)
        }
        
        
        //stringFunc()
     
    }
    
    func stringFunc() {
        // String。
        /*
         Swift中String，并不想oc中，是对象。
         
         */
        let a: String = "Hello,Swift"
        // 字符串遍历。
        for (index,char) in a.enumerated() {
            
            print(index,char)
        }

        let start: String.Index = a.startIndex
        let end = a.index(a.endIndex, offsetBy: -2)
        print(a[start..<end])
        
        // 字符串拼接。
        let b = a + "!"
        var c = "这是b：\(b)"
        c.append("Y")
        c.append("拼接完成！")
        
        
        // 大小写转换。
        print(c.uppercased())
        print(c.lowercased())
        
        // 字符串截取。字符串截取后，获取的其实就是SubString结构体。
        let d: Substring = c.prefix(3)
        let e: Substring = c.suffix(2)
        let indexS = c.startIndex
        let indexE = c.index(c.endIndex, offsetBy: -10)
        let f:Substring = c[indexS...indexE]
        print(c.count)
        print(d)
        print(e)
        print(f)
        print(String(f))
        print(type(of: f), type(of: d), type(of: e))
        
        // 判断字符串是否为空。
        let em:String = ""
        print(em.isEmpty)
        
        // 字符串索引。
        let sIndex = c.startIndex
        print(c[sIndex])
        
        

    
    }


}
