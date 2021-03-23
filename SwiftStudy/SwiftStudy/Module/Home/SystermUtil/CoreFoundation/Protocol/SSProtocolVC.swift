//
//  SSProtocolVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2019/12/28.
//  Copyright © 2019 Zhu ChaoJun. All rights reserved.
//

import UIKit


/*
 关于协议的细节，协议可以声明属性和方法，属性用var xx {set get} 来修饰。
 方法中，类方法始终用static来修饰。
 
 协议如果声明了init构造方法，那么遵循这个协议的类或者结构体就必须实现init构造方法，并且使用require关键字。
 
 协议中的方法没有可选类型了关键字了，不像oc中有@optional关键字。 但是我们可以通过协议扩展优雅的实现可选方法。
 当然如果我们非要使用optional和required这些oc关键字，那么就必须增加@objc关键字。
 
 
 */
class SSProtocolVC: SSBaseViewController {
    
    /// 我们需要注意下面几种写法的区别。
    // 我们需要记住： 带=的，就是初始化，也就是在该类初始化的时候，就会进行赋值。 而且只会赋值一次。但是有一个特例，就是用lazy修饰的属性，是延时加载的。
    
    // 不带=的，其实就是重写set、get方法，每次调用set和get都会调用，像下面只有return，说明是read-only的，也间接的说明他是计算属性。
    var name: String {
        print("name is already do")
       return "name"
    }
    
    var name1: String = {
        print("name1 is already do")
        return "name1"
    }()
    
    lazy  var name2: String = {
        print("name2 is already do")
        return "name2"
    }()
    
    lazy var name3 = "name3"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        titleName = "Protocol"
        desLab.text = "关于协议Protocol，里面的属性，只能 var {set get} 这种形式来声明。 关于泛型协议、面向协议编程等实现方式。"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(name,name1, name2, name3)
    }

    @IBAction func shakeableButtonClick(_ sender: UIButton) {
        
        //sender.shake()
        let squareI = SquareIterator()
        while let next = squareI.next() {
            print(next, squareI.state)
        }
    }
}



/*
 
 这种写法是标准的面向协议编程。 好好体会这种写法，到底怎么优于OOP的。
 
 protocol进行类型限定。有点类似dart中，mixin XXX<T extents StatefullWidget> on State<T> {}
 对于一些多个类都具有的特性明显采用协议的方式比继承更加优秀，而且可以避免采用继承的代码耦合性。
 
 比如要实现抖动效果，传统OOP的思路，可能是设置一个ShakeAbleClass作为基类，那么如果想要实现抖动效果，只需要类继承
 ShakeAbleClass就可以。这样咋一看没什么问题，但是，类之间的耦合性明显变强，使继承关系变得很复杂，比如我现在想要增加一个
 渐变动画，那么由于没有多继承的能力，我们只能在ShakeAbleClass 增加一个 opacity方法。 这样久而久之，ShakeAbleClass
 就会也会变得非常复杂。
 
 那么有人会说，因为ios引入了 extentsion， 所以我们给基类增加一个extensiton，比如extension: UIView 里面增加
 shake函数。但是这样的话，明显设计不合理，因为，我们需求可能是UIButton和UIImageView才会有shake抖动的能力，但是
 如果给UIView增加分类，明显所有的继承UIView都有shake能力，如UILable等。
 
 如果面向协议，那么我们就能避免上面面临的这些问题。即可以将代码分开、同时也能将功能更加独立。
 
 协议扩展。
 一个协议的属性、方法是必须实现的。
 当然我们可以通过协议扩展来默认实现这些属性方法。
 
当前我们可以设置为optionnal，但是没有 extension来的方便。
当extension和 遵循的类都实现协议的话，那么会先调类里面的方法。
 
 */
protocol ShakeAble where Self: UIView {
    func shake()
}
extension ShakeAble {
    func shake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 5
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 4.0, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 4.0, y: self.center.y))
        layer.add(animation, forKey: nil)
    }
    
}

extension UIButton: ShakeAble {
    

}



// 协议中的属性和方法。
protocol SSProtocol: class {
    var name: String { get }
    func protocolFunc1()
    
    
    func protocolFunc2()
    
}

extension SSProtocol {
    
    var name: String {
       return "默认"
    }
    func protocolFunc1() {
        print("extension protocolFunc1")
    
    }
}




/*
  swift中常见的协议。
 1、CustomStringConvertible。 有description属性。
 2、Equatable。有 == 方法。
 3、Comparable。有 < 方法。当然Commparable是继承Equalbe的。
 4、Sequence。 序列化。依赖另一个协议IteratorProtocol。是swift中集合体系的一个起点。所有遵循该协议的的对象都可以使用for in进行遍历。
 5、IteratorProtocol。 迭代器。
 6、Collection集合。继承自Sequence序列。Swift中数组、字典、字符串都是遵循了该协议。
        其特点：1、startIndex、endIndex。第一个和最后一个元素。
        2、subScript。通过下标访问集合。
        3、indices：集合的索引。
 7、RangeExpression。常用的Range是遵循该协议的。
 */



class SystermProtocolClass {
    
    
    static let a:String = ""
    static func staticFunc() {
        
       
        
        
    }
    
    
}

extension SystermProtocolClass: CustomStringConvertible {
    
    var description: String {
        return "CustomStringConvertible"
    }
}

extension SystermProtocolClass: Equatable {

    // lhs表示左边（left hand side）。 rhs表示右边（right hand side）。
    static func == (lhs: SystermProtocolClass, rhs: SystermProtocolClass) -> Bool {
        return false
    }

}

extension SystermProtocolClass: Comparable {
    static func < (lhs: SystermProtocolClass, rhs: SystermProtocolClass) -> Bool {
        return true
    }

}


class SquareIterator: IteratorProtocol {
    
    var state = (current: 0, next: 1)
    typealias Element = Int
    
    func next() -> Int? {
        let next = state.next
        if next == 10 {
            return nil
        }
        state = (current: next, next: next+1)
        return next * next
    }
}


// 固定类型遵循泛型协议，一定要指定typealias 类型。
extension SystermProtocolClass: Sequence {

    typealias Iterator = SquareIterator
    func makeIterator() -> SquareIterator {
        return SquareIterator()
    }
}

