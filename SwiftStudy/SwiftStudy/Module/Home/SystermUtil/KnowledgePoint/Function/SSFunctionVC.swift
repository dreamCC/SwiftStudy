//
//  SSFunctionVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2019/12/26.
//  Copyright © 2019 Zhu ChaoJun. All rights reserved.
//

import UIKit
import SnapKit

/*
 
 a)通过元祖，返回多个值。
 b)
 c)注释。注意描述和详细描述需要空一行。
 d)可以修改参数标签。 func mineFunc（at name: String）, 相当于修改了参数标签。
 e)下划线省略标签。
 f)默认参数值。func mineFunc（at time：String = ”8：00“） 这种方式修改时间。 但又省略标签的时候，就会有限制。
 g)可变参数。其实可变参数是一个数组，我们通过print打印，可以看到其结果。
 i.明显比oc更容易取值。
 h)输入输出标签，intout本质是地址传递，可以使用汇编来看其原理。
     
 i)函数重载。也就是函数名和返回值相同，但是参数不同，就会构成重载。如上图所示：
 i.
 j)内联函数。Inline function，如上图：默认debug模式，没有开启优化optimization， release模式下回开启优化，会将一些函数转换成内联函数。
 i.
 ii.内敛函数就是直接将函数体展开。防止没必要的，函数调用时候，在栈中开辟栈空间和销毁栈空间。上述代码，相当于直接调用print（”hello“）。 如果在test（）打断点，其实是不会捕捉到代码的。
    @inline(never) 、@inline(__always)当编译器打开内敛优化的话，会进行优化。
 iii.如果函数体内容特别多、递归、动态派发（类似oc中的多态）。是不会内敛的。
 iv.嵌套函数。
 v.函数可以当做一个类型。
 
 
 */

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
        // 有参数有返回值。 有点类似闭包
        self.hasParaReture = { (name, age)->String in
            
            return "\(name) + \(age)"
        }
        
        // 上面的写法，也可以简写。如：我们常见于数组的高级用法中，比如sort、map、filter、reduce等。
        self.noPara = {}
        self.hasPara = { print("\($0) + \($1)" ) }
        self.hasParaReture = { "\($0) + \($1)" }
    }
    
    // 无参，无返回值。
    @inline(never) func noparames() {
        print("无参、无返回值类型")
    }
   
    // 有参数，无返回值。
    @inline(__always) func paramesFunc(inputUserName name: String) {
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
    
    // 可变参数。 可变参数，通过打印可以发现就是一个数组。
    func changeParames(name: String...) {
        print(type(of: name))
    }
    
    
}
