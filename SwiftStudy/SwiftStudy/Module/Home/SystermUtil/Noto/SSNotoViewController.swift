//
//  SSNotoViewController.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2021/1/5.
//  Copyright © 2021 Zhu ChaoJun. All rights reserved.
//

import UIKit


/// Description
class SSNotoViewController: SSBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    // 单行注释。 不会出现在summary中。
    func notoOnlyLine() {
        /* 单行注释 */
        let name = "姓名"
        
        /// 可以出现在summary中, 如果想要是多行，可以直接往后添加 ///
        /// 多行----
        let show = name + "= David"
        print(show)
        
        /**
         可以使用这种方式进行多行注释，或者单行。
            
         */
        let other = "e"
        print(other)
        
        
       
    }
    
    /// 描述 支持markdown
    ///
    ///  # 一级标题
    ///  正常内容
    ///
    ///  ## 二级标题
    ///  *斜体内容*
    ///
    ///  ### 三级标题
    ///  **粗体内容**
    ///
    ///  #### 四级标题
    ///
    ///  * 前面是点
    ///  - 前面是点
    ///  + 前面是点
    ///
    ///   ```
    ///   // 支持代码快
    ///   let name = ""
    ///   ```
    /// - Note: 标记    ///
    ///
    /// - Parameters:
    ///   - name: 姓名
    ///   - age: 年级
    /// - Returns: 返回值
    
    func numbersNoto(name: String ,age: String) -> Bool {
        
        return true
    }
    
    
}
