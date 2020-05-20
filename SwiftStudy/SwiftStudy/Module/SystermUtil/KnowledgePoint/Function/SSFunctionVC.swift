//
//  SSFunctionVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2019/12/26.
//  Copyright © 2019 Zhu ChaoJun. All rights reserved.
//

import UIKit
import SnapKit

class SSFunctionVC: UIViewController {
  
    // 无参、无返回值
    var noPara: (()->())!
    
    // 有参、无返回值
    var hasPara: ((String, Int)->())!
    
    // 有参有返回值
    var hasParaReture: ((String, Int)->String)!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        view.backgroundColor = UIColor.white
        navigationItem.title = "Function"
        
        let lab = UILabel()
        lab.text = "Swift中引入了函数类型，其中闭包closesure就属于函数类型。\n\n1、对于常规函数。需要注意几种情况有函数标签和变量的使用。paramesFunc(inputUserName name: String)。\n\n2、当有默认值时候的使用。hasDefaultValue(name: String, age: Int = 18, heigh: Float = 180.0)。这种情况下的调用，只有name是必须传入的，像age、heigh是可选传入的。可以通过如下方式调用：\n  hasDefaultValue(name: \"David\")\n  hasDefaultValue(name: \"Lily\", age: 20)\n  hasDefaultValue(name: \"Lucy\", age: 23, heigh: 190)。\n\n3、可变参数。一般是类型后面...，其实参数类型就是一个数组。而且调用通过逗号分开，可参考print方法。 \n\n4、关于函数类型和闭包之前的关系和写法问题。 通常，我们写一个func funcName()->() {} 这样的函数，那么funcName是一个函数，属于函数类型，我们可以通过type(of: funcName) 来获取该函数类型。 闭包，其实也属于函数类型，一般我们称之为匿名函数。 函数类型的调用，和我们调用函数是一样的。"
        lab.numberOfLines = Int.max
        lab.lineBreakMode = .byCharWrapping
        view.addSubview(lab)
        lab.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
        }
        
        //noparames()
        //paramesFunc(inputUserName: "输入的名字")
        
        //hasDefaultValue(name: "David")
        //hasDefaultValue(name: "Lily", age: 20)
        //hasDefaultValue(name: "Lucy", age: 23, heigh: 190)
        
        changeParames(name: "hello", "swift")
        
        print(type(of: noparames))
        print(type(of: self.noPara))
        
        self.noPara = noparames // 这种写法完全正确。
        // 通过匿名函数的形式，其实也就是我们常说的闭包形式。 没有返回值，所以 ->() 省略。
        self.hasPara = { (name, age) in
            
        }
        // 有参数有返回值。
        self.hasParaReture = { (name, age)->String in
            
            return "\(name) + \(age)"
        }
        
        // 上面的写法，也可以简写。如：我们常见于数组的高级用法中，比如sort、map、filter、reduce等。
        self.noPara = {}
        self.hasPara = { print("\($0) + \($1)" ) }
        self.hasParaReture = { "\($0) + \($1)" }
    }
    
    // 无参，无返回值。
    func noparames() {
        print("无参、无返回值类型")
    }
   
    // 有参数，无返回值。
    func paramesFunc(inputUserName name: String) {
        print(name)
    }
    
    // 有默认值。
    func hasDefaultValue(name: String, age: Int = 18, heigh: Float = 180.0) {
        print(name, age, heigh)
    }
    // 当有默认值和没默认值，同时存在的时候，如果我们调用，hasDefaultValue(name: "")， 这个时候会调用
    // 无默认值的方法。
    func hasDefaultValue(name: String) {
        print(name)
    }
    
    // 可变参数。
    func changeParames(name: String...) {
        print(type(of: name))
    }
    
    
}
