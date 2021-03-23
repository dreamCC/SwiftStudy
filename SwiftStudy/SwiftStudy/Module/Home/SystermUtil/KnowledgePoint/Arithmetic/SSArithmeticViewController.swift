//
//  SSArithmeticViewController.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2021/2/25.
//  Copyright © 2021 Zhu ChaoJun. All rights reserved.
//

import UIKit

class SSArithmeticViewController: SSBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let ary = [8, 9, 4, 5, 2, 1]
        
        bubbleSort(ary: ary)
        insertSort(ary: ary)
    }

    
    // 冒泡排序。
    private func bubbleSort(ary: [Int]) {
        var mAry = ary
        for i in 0 ..< ary.count - 1 {
            for j in 0 ..< ary.count - 1 - i {
                if mAry[j] > mAry[j + 1] {
                    let temp = mAry[j + 1]
                    mAry[j + 1] = mAry[j]
                    mAry[j] = temp
                }
            }
        }
        print(mAry)
    }
    
    // 插入排序。 其中待插入的数据其实是一个标准。
    private func insertSort(ary: [Int]) {
        
        var mAry = ary
        for i in 1 ..< mAry.count {
            let temp = mAry[i]
            
            for j in stride(from: i - 1, through: 0, by: -1) {
                if temp < mAry[j] {
                    mAry[j + 1] = mAry[j]
                    mAry[j] = temp
                }
            }
        }
        print(mAry)
    }
}
