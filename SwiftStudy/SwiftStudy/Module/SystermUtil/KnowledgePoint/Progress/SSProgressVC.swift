//
//  SSProgressVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/1/7.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit

class SSProgressVC: UIViewController {

    @IBOutlet weak var progressV: UIProgressView!
    
    /*
     
     进度管理器。
     主要是对耗时操作了，有了更加直观的管理。
     常用属性：completedUnitCount、totalUnitCount、fractionCompleted进度值。
     
     而且还能添加多个子任务。
     当有多个子任务的时候，注意处理细节：
     subProgress1 = Progress(totalUnitCount: 10, parent:progress , pendingUnitCount: 40)
     subProgress2 = Progress(totalUnitCount: 10, parent: progress, pendingUnitCount: 60)
     1、subProgress1的pendingUnitCount + subProgress2的pendingUnitCount = progress的total。
     
     总的来说，当有多个任务的时候， 整个任务结构类似树形结构。
     
     */
    lazy var progress: Progress = {

        return Progress(totalUnitCount: 100)
    }()
    
    var subProgress1: Progress!
    var subProgress2: Progress!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        subProgress1 = Progress(totalUnitCount: 10, parent:progress , pendingUnitCount: 40)
        subProgress2 = Progress(totalUnitCount: 10, parent: progress, pendingUnitCount: 60)
        
    }


    @IBAction func setProgress(_ sender: UIButton) {
        self.subProgress1.completedUnitCount += 1
        self.subProgress2.completedUnitCount += 1
        
        self.progressV.progress = Float(self.progress.fractionCompleted)
        
        print(self.progress.completedUnitCount,
              self.progress.totalUnitCount,
              self.progress.fractionCompleted)
    }
    
}
