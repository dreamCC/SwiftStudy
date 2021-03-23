//
//  SSAnyAnyObjectVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2019/12/23.
//  Copyright © 2019 Zhu ChaoJun. All rights reserved.
//

import UIKit
import SnapKit

/*
 @objc public protocol AnyObject { }。AnyObject就是一个协议，而且The protocol to which all classes implicitly conform. 也就是说所有的类都隐式的遵循了该协议。
 
 public typealias Any = protocol<>。 Any其实也是一个协议，而且The protocol to which all types implicitly conform. 也就是说所有的类型都隐式遵循了该协议。即所有的类型都能用Any表示
    class、struct、enum、func等。

 public typealias AnyClass = AnyObject.Type。AnyClass表示任意类型的元类型。The protocol to which all class types implicitly conform. 也就是说所有的类都隐式遵循了该协议。
 
 MetaType表示元类型，通过type(of:)来获取。也可以通过AnyClass.self来获取。两者的区别是.self只能表示编译时候
    的元类型，即声明的元类型，而type(of: )表示运行时候的元类型。type(of: self) == SSAnyAnyObjectVC.self
 
 Swift中，类增加了命名空间。
 */

struct Pers {
    
}
class SSAnyAnyObjectVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        navigationItem.title = "AnyAnyObject"
        extendedLayoutIncludesOpaqueBars = true
        
        let textLab = UILabel()
        textLab.text = "AnyObjec和Any的关系和区别。官方解释：AnyObject可以表示任意class。Any可以表示任意类型，甚至方法（func）类型。AnyObject实际上是一个协议，所以也就是说，任意class都是隐式遵循了这个协议，这也是AnyObject只适用于class的原因。这就有个问题，比如swift中还有很多值类型的，比如Arrary、Dictionary等。官网上有句话(The protocol to which all classes implicitly conform.)"
        textLab.numberOfLines = Int.max
        view.addSubview(textLab)
        textLab.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
        }
        
    
        
        // 如果数组声明为AnyObject。那么其元素就需要时class类型。所以Int、String这种基础数据类型就需要进行转换。
        var a: Array<AnyObject> = [AnyObject]()
        a.append(NSNumber(2))

        /// 这里同时需要关注AnyObject和AnyClass的关系。
        /*
         AnyObject可以表示任意类。
         AnyClass 其实就是AnyObject.Type。表示元类型。
         那么AnyClass和AnyObject.Type获取的方式，是通过Class.self来获取的。
         
         注意.self的用法。.self用在AnyObject后面，取的是类型的本身。用在实例后面区的是取实例本身。
         */
        
        
        SSAnyAnyObjectVC.tesClas()
        type(of: self).tesClas()
        SSAnyAnyObjectVC.self.tesClas()
        print(type(of: self) == SSAnyAnyObjectVC.self)
        

    }
    
    class func tesClas() {
        print("-----tesClas")
    }
}
