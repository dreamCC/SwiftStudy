//
//  SSGenericityVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/1/2.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.

import UIKit

final class MyKf<Base> {
    public let base: Base
    init(base: Base) {
        self.base = base
    }
}

protocol MyKfCompatible {
    associatedtype CompatibleType
    var kf: CompatibleType {get}
}

extension MyKfCompatible {
    var kf: MyKf<Self> {
        return MyKf.init(base: self)
    }
}
extension UIView: MyKfCompatible {}
extension MyKf where Base == UIView {
    func testFunc() {}
}


class SSGenericityVC: SSBaseViewController {
    
    static let staticValue = "staticValue"
    let objectValue = "objectValue"
    

    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.titleName = "泛型"
        self.desLab.text = "泛型对于我们写Lib、Framework、SDK很有帮助。可以让我们写很多通用代码。现在很多好的语言都是支持泛型的。Swift中泛型主要有以下：\n\n1、泛型函数。func swapTwoItem<T>(item1:inout T, item2:inout T) {}。特别注意其写法。 而且在调用的时候不能指定类型，swapTwoItem<Int>(item1: &item1, item2: &item2)，这个时候会报错。只能swapTwoItem(item1: &item1, item2: &item2)调用。同时<T: Comparable>是可以对T进行约束的。func someFunction<T : SomeClass, U : SomeProtocol> (someT : T, someU : U)，两个类型也是可以的。\n\n2、泛型类型。struct Stack<T> {}。var stack = Stack<Int>()，注意和泛型函数的区别，泛型函数调用的时候不能指定类型。但是泛型类型，初始化的时候需要指定类型，不然那都会报错。同样我们可以约束其类型 struct Stack<T: StringProtocol> 。\n\n3、泛型协议。注意和泛型函数、泛型类型的区别。protocol Container<T>{} 这种写法会报错。Protocols do not allow generic parameters; use associated types instead。很明显泛型协议，需要借助associated来设置。 而且，普通类型遵循协议，就必须借助typealias ItemType = Int。泛型类型可以省略，注意泛型类型遵循泛型协议的写法，参考Demo"
        
        print(self.objectValue, Self.staticValue, SSGenericityVC.staticValue)
        
 
    }
    
    @IBAction func geneicityFunc(_ sender: UIButton) {
        var item1 = 12
        var item2 = 14
        swapTwoItem(item1: &item1, item2: &item2)
        print(item1, item2)
        
        var item3 = "hello", item4 = "swift"
        swapTwoItem(item1: &item3, item2: &item4)
        print(item3,item4)
        
        print(comparaTwoItem(itme1: 12, item2: 14))
    }
    
    @IBAction func genericityType(_ sender: UIButton) {
        
        var stack = Stack<String>()
        stack.push(item: "12")
        stack.push(item: "13")
        stack.push(item: "14")
        print(stack.items)
        
        stack.pop()
        print(stack.items)
    }
    
    @IBAction func genericityProtocol(_ sender: UIButton) {
        
        //fixTypeConfirmProtocol()
        genericityTypeConfirmProtocol()
    }
    
    // 固定类型，遵循泛型协议。
    func fixTypeConfirmProtocol() {
        
        var intStack = IntStack()
        intStack.append(item: 12)
        intStack.push(item: 14)
        intStack.append(item: 13)
        print(intStack.items)
        
        intStack.pop()
        print(intStack.items, intStack.count)
        
        print(intStack[0], intStack[1])
    }
    
    // 泛型类型，遵循泛型协议。
    func genericityTypeConfirmProtocol() {
        
        var stringStack = CommonStack<String>()
        stringStack.append(item: "hello")
        stringStack.push(item: "swift")
        stringStack.append(item: "I")
        print(stringStack.items)
        
        stringStack.pop()
        print(stringStack.items, stringStack.count)
        
        print(stringStack[0], stringStack[1])
        
        
        var intStack = CommonStack<Int>()
        intStack.append(item: 12)
        intStack.push(item: 14)
        intStack.append(item: 13)
        print(intStack.items)
        
        intStack.pop()
        print(intStack.items, intStack.count)
        
        print(intStack[0], intStack[1])
        
      
    }
    
}




/***************************************************************************/
// 泛型函数
extension SSGenericityVC {
    
    func swapTwoItem<T>(item1:inout T, item2:inout T) {
        let temp = item1
        item1 = item2
        item2 = temp
    }
    
    // 可以进行泛型约束
    func comparaTwoItem<T: Comparable>(itme1: T, item2: T) -> Bool {
        return itme1 < item2
    }
}

/***************************************************************************/
// 泛型类型。
struct Stack<T> {
    var items = [T]()
    mutating func push(item: T) {
        items.append(item)
    }
    mutating func pop() {
        items.removeLast()
    }
}



/***************************************************************************/
// 泛型协议。
protocol Container {
    associatedtype ItemType
    mutating func append(item: ItemType)
    var count: Int { get }
    subscript(index: Int) -> ItemType { get }
}


// 普通类型遵循协议。需要 typealias ItemType = Int
struct IntStack: Container {
  
    var items = [Int]()
    mutating func push(item: Int) {
        items.append(item)
    }
    
    mutating func pop() {
        items.removeLast()
    }
    
    // confirm protocol
    typealias ItemType = Int
    mutating func append(item: Int) {
        items.append(item)
    }
    
    var count: Int {
        return items.count
    }
    
    subscript(index: Int) -> Int {
        return items[index]
    }
    
}

// 泛型类型遵循泛型协议。
struct CommonStack<T>: Container {
    
    var items = [T]()
    
    mutating func push(item: T) {
        items.append(item)
    }
    
    mutating func pop() {
        items.removeLast()
    }
    
    // confirm protocol
    typealias ItemType = T
    mutating func append(item: T) {
        items.append(item)
    }
    
    var count: Int {
        return items.count
    }
    
    subscript(index: Int) -> T {
        
        return items[index]
    }
 
}



