//
//  SSArraryVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2019/12/24.
//  Copyright © 2019 Zhu ChaoJun. All rights reserved.
//

import UIKit
import SnapKit

class SSArraryVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Array"
        view.backgroundColor = UIColor.white
        
        let desLab = UILabel()
        desLab.numberOfLines = Int.max
        desLab.font = UIFont.systemFont(ofSize: 14)
        desLab.text = "Swift中数组也是结构体，public struct Array<Element>，我们发现其实是泛型集合。常用方法：\n1、初始化[xx, xx]、[Int]()、Arrary<Int>()，其中后面两个可以有reapeating count的方式赋值。\n2、增加元素。ary.append()。增加多个元素，也可以使用ary += [xx,xx]，相当于ary += ary的方式增加多个元素。ary.insert 可以在任意位置增加元素。\n3、删。通过ary.remove进行删除。如：ary.removeFirst（如果数组为空同样会报错）、ary.removeLast(注意，如果ary为空，那么调用remolast会报错，可使用poplast代替。)、ary.removeAll(keepingCapacity: 是否保存其容器值), removeSubRange(Range(NSMakeRange(1,4)))注意Range可以通过NSRange来获取，也可以通过区间1...4。如ary.removeSubRange(1...4)。\n4、改。a[0] = xx, a[1...4] = [xx,xx,xx,xx] Swift增加了通过区间修改元素的能力。\n5、查。a[0]、a[1...4]通过下标或者区间进行查找，注意a[1...3] 返回的是ArraySlice结构体，和String、SubString的关系有点像，同样是共用一块相似的存储空间,而且其下标还是和Array下标对应。\n5、常用其它函数：ary.count、ary.isEmpty、ary.startIndex（下标）。\n6.遍历。for index in 0..<ary.count、 for index in stride(xxxxx)、for item in ary、for （index，item） in ary.enumater、ary.forEach。其中常用的forEach、for in。\n数组的特殊函数：\n1、过滤ary.filter({(item)-> Bool in return item > 5 })、ary.fileter{$0 > 7}。第二种是精简写法。\n2、映射map、flatMap，和其它语言一样。也可使用$0这种语法糖。flatMap只是在原有的基础上增加将二维数组转换为一维数组的能力、去除数组中nil、以及强制解包的能力。\n3、reduce对数组中所有元素进行递归计算。ary.reduce(0, +)。相当于从0 + 数组中的所有元素。 当然第二个参数还可以是 - * /。还有两种写法，请参数demo。\n4、prefex、sufex以及与其相补的方法dropFirst、dropLast(3)删除3个元素后的全部元素。\n5、通过sorted进行排序。具体使用，请参考下方Demo。"
        view.addSubview(desLab)
        desLab.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
        }
     
        //arrayFunc()
        

        
    
    }
   

    func arrayFunc() {
     
        // 初始化
        var a = [1]
        let a1 = [Int]()
        let a2 = Array<Int>()
        
        let b = [1,2,3]
        let b1 = [Int](repeating: 1, count: 3)
        let b2 = Array<Int>(repeating: 1, count: 3)
        
        print(a, a1, a2)
        print(b, b1, b2)
        
        // 增。分为单个增加和多元素增加。
        a.append(2)
        a += [3]
        a = a + [4,5,6]

        
        a.insert(7, at: 4)
        a.insert(contentsOf: [8, 9], at: 5)
        
        
        
        // 删
        a.remove(at: 7)
        a.removeLast()
        a.removeFirst()
        a.removeAll()
        a.removeAll(keepingCapacity: true)
        //a.removeLast() // 会报错
        _ = a.popLast()
        //a.removeFirst() // 会报错，因为数组为空
        
        a += [1,2,3,4,5,6,7]
        let range = Range(NSMakeRange(1, 4))
        a.removeSubrange(range!)
        a.removeSubrange(1...2)
        print(a)
        
    
        // 改。
        a += [2,3,4,5,6]
        a[0] = 9
        a[1...3] = [8,7,6]
        
        print(a)
        
        // 查。
        let c:ArraySlice = a[1...4] // 这个时候返回的是ArraySlice结构体。
        print(c)
        print(a[0])
            
        // 其它常用方法。
        print(a.max())
        print(a.isEmpty)
        print(a.count)
        print(a.min())
        print(a.endIndex)
        
        // 遍历。
        for index in 0..<a.count {
            print(a[index])
        }
        
        for index in stride(from: 0, to: a.count, by: 2) {
            print(a[index])
        }
        
        for item in a {
            print(item)
        }
        
        for (index, item) in a.enumerated() {
            print("\(index)的值是\(item)")
        }
        
        a.forEach { (item) in
            print(item)
        }
    
        // 数组的特殊用法。
        // 过滤
        let new_ary1 = a.filter { (item) -> Bool in
            return item > 7
        }
        let new_ary11 = a.filter{ $0 > 7}
        print(new_ary1)
        print(new_ary11)

        // 映射
        let new_ary2 = a.map { (item) -> String in
            return "映射后\(item)"
        }
        let new_ary22 = a.map { "映射：\($0)" }
        print(new_ary2)
        print(new_ary22)

        // reduce对数组中的所有元素进行计算。
        let reduceAry = [1,2,3,4,5]
        let result = reduceAry.reduce(0) { (start, item) -> Int in
            return start + item
        }
        let result1 = reduceAry.reduce(5, +)
        let result2 = reduceAry.reduce(10) { $0 + $1 }
        let result3 = reduceAry.reduce(into: 5) { (start, end) in
            start = 10
        }
        print(result)
        print(result1)
        print(result2)
        print(result3)
        
        
        // sort进行排序
        let sort1 = a.sorted(by: <)
        let sort2 = a.sorted { (item1, item2) -> Bool in
            return item1 < item2
        }
        let sort3 = a.sorted { $0 < $1}
        print(sort1)
        print(sort2)
        print(sort3)

        
       
    }
    
}
