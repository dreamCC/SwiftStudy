//
//  SSRangeVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2019/12/26.
//  Copyright © 2019 Zhu ChaoJun. All rights reserved.
//

import UIKit

class SSRangeVC: SSBaseViewController {

    // Range可以通过 ... 语法，或者通过NSRange来进行初始化。
    override func viewDidLoad() {
        super.viewDidLoad()

     
        self.titleName = "Range"
        self.desLab.text = "Range顾名思义就是一个区间，swift中，就是一个结构体。那么Swift中Range的具体表现有如下5中： \n\n1、CloseRange结构体。表示闭区间，相应的CountableCloseRage知识tpyealias CloseRange。\n\n2、Range表示开区间，相应的CountableRage也是typealias Range。\n\n3、swift 4.0之后新增半开区间，PartialRangeFrom，PartialRangeThrough和PartialRangeUpTo等。\n\n4、 public struct Range<Bound> where Bound : Comparable\npublic struct ClosedRange<Bound> where Bound : Comparable\npublic struct PartialRangeThrough<Bound> where Bound : Comparable\npublic struct PartialRangeFrom<Bound> where Bound : Comparable\npublic struct PartialRangeUpTo<Bound> where Bound : Comparable\n这5中类型的声明，都是有一个泛型Bound,而且Bound需要遵循Comparable协议。也就是： 只要遵循Comparable协议，都能写成Range的样式。幸运的是在swift中，绝大数的基础数据类型都遵循了Comparable协议，所以都能有Range的写法。\n\n5、extension Range : RangeExpression{} 而RangeExpression这个协议，有container方法。所以我们也可以：使用contain方法。"
        
        rangeFunc()
    }
    
    func rangeFunc()  {
        
        // 闭区间。
        // public typealias CountableClosedRange<Bound> = ClosedRange<Bound> where Bound : Strideable, Bound.Stride : SignedInteger
        let a: ClosedRange = 0...4
        let a1: CountableClosedRange = 0...4
        
    
        // 开区间。
        //public typealias CountableRange<Bound> = Range<Bound> where Bound : Strideable, Bound.Stride : SignedInteger
        let b: CountableRange = 0..<4
        let b1: Range = 0..<4
        
        // 单侧区间。
        let c: PartialRangeFrom = 0...
        let c1: PartialRangeThrough = ...4
        let c2: PartialRangeUpTo = ..<4
        let c3: CountablePartialRangeFrom = 0...

        
        print(a,a1,b,b1)
        print(c,c1,c2,c3)
        
        /*
         
         public struct Range<Bound> where Bound : Comparable
         public struct ClosedRange<Bound> where Bound : Comparable
         public struct PartialRangeThrough<Bound> where Bound : Comparable
         public struct PartialRangeFrom<Bound> where Bound : Comparable
         public struct PartialRangeUpTo<Bound> where Bound : Comparable
         
         这5中类型的声明，都是有一个泛型Bound,而且Bound需要遵循Comparable协议。也就是： 只要遵循Comparable协议，都能写成Range的样式。幸运的是在swift中，绝大数的基础数据类型都遵循了Comparable协议，所以都能有Range的写法。
         */
        
        let str = "a"..."z"
        let date = Date(timeIntervalSince1970: 0)...Date()
        let indexRange = IndexPath(item: 0, section: 0)...IndexPath(row: 1, section: 0)
        
        //let vc = SSRangeVC()...UIViewController() 这样写，显然就不行，因为UIViewController和SSRanageVC没有遵循Comparable协议。
        print(str, date,indexRange)
        
        // extension Range : RangeExpression 。而RangeExpression这个协议，有container方法。所以我们也可以：
        print(str.contains("c")) // true, contains方法就是在RangeExpression 协议里面
        
        
    }

}
