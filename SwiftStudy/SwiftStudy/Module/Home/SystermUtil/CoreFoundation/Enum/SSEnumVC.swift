//
//  SSEnumVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2019/12/23.
//  Copyright © 2019 Zhu ChaoJun. All rights reserved.
//

import UIKit
import SnapKit


/*
 
 枚举enum是不具有构造方法的。而且没有存储属性（也就是没有成员变量）。
 
 枚举的关联值是不能相等的。
 
 枚举里面添加方法的好处。可能增加枚举的功能性。
 
 indirect 递归枚举。
 
 enum Seaon: Int {
     case Year = 1, day, week
 }

 let s = Seaon(rawValue: 2)
 
 枚举的初始化方式，如果有原始值，可以直接通过rawValue进行初始化。
 
 */
class SSEnumVC: UIViewController {

    let y = Year.month("month")
    let y2 = Year.secnod(12, "second")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        view.backgroundColor = UIColor.white
        navigationItem.title = "枚举"
        

    
        
        
        let desLab = UILabel()
        desLab.numberOfLines = Int.max
        desLab.text = "enum枚举。相对于其他语言的特点：\n1、默认是没有原始值的。一般语言枚举默认是Int类型的，但是swift中，如果你不指定原始值类型，那么默认是没有类型的，即不能通过enum.rawvalue来获取值。\n2、原始值可以是Int、Double、Float、String、Bool类型，当然我们也可以自定类型。\n3、我们可以有绑定值。如case a(String)等。注意绑定值的解析方法，参考下面Demo。\n3、枚举中的函数。如下Level，其重要特点是通过swift self 来进行不同case的处理。\n4、枚举中的属性。和函数是一样的。"
        view.addSubview(desLab)
        desLab.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let w = Week.two
        if w == .two {
            print(w.rawValue)
        }
        
        // 这里需要把y放在函数体外面。不然会报Switch condition evaluates to a constant
        switch y {
        case Year.month(let value):
            print(value)
        default:
            print("没有值")
        }
        
        if case Year.month(let name) = y {
            print(name)
        }
        
        
        let leval = Level.mid
        leval.des()
        
        if case let Year.secnod(first, seconde) = y2 {
            print(first, seconde)
        }
       
    }

}

enum Week: String {
    case one
    case two = "hello,world"
    case three
}



enum Level:Int {
    case hight, mid, low
    
    var isGood: String {
        switch self {
        case .hight:
            return "YES"
        default:
            return "NO"
        }
    }
    
    
    
    
    func des() {
        switch self {
        case .hight:
            print("成绩很好")
        case .mid:
            print("成绩一般")
        case .low:
            print("成绩很差")
        }
    }
}


enum Year {
    
    
    case month(String)
    case secnod(Int, String)
    
    func enumFunc() {
        switch self {
        case .month(let value):
            print(value)
        case .secnod(let index, let value):
            print(index, value)
        }
    }
    
    subscript(index: Int) -> Int{
        return index
    }
    
}




