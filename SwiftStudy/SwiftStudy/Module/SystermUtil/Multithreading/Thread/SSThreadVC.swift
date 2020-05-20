//
//  SSThreadVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/4/22.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit

class SSThreadVC: SSBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        titleName   = "Thread"
        desLab.text = "Thread是类，和oc中NSThread的用法和使用基本一样"
        
        threadInit()
        
        threadClass()
    }
    
    private func threadInit() {
        let thread = Thread {
            print("thread- init", Thread.current)
        }
        thread.start()
        
    }
    
    private func threadClass() {
        Thread.detachNewThread {
            print("detach-block",Thread.current)
        }
        
        Thread.detachNewThreadSelector(#selector(threadStart), toTarget: self, with: nil)
    }

    @objc func threadStart() {
        print("detach selector", Thread.current)
    }

}
