//
//  SSRunloopVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/6/17.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit

class SSRunloopVC: QMUICommonViewController {

    var tTread: Thread!
    
    override func didInitialize() {
        super.didInitialize()
        tTread = Thread(target: self, selector: #selector(openThread), object: nil)
        tTread.name = "current-"
    }
    
    override func initSubviews() {
        title = "runloop"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "👉",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(printThreadMsg))
        
        let runloopBtn = QMUIButton()
        runloopBtn.setTitle("RunLoop", for: .normal)
        runloopBtn.addTarget(self, action: #selector(runloopBtnClick), for: .touchUpInside)
        view.addSubview(runloopBtn)
        runloopBtn.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        let closeRunloop = QMUIButton()
        closeRunloop.setTitle("closeRunloop", for: .normal)
        closeRunloop.addTarget(self, action: #selector(closeRunloopClick), for: .touchUpInside)
        view.addSubview(closeRunloop)
        closeRunloop.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(runloopBtn.snp.bottom).offset(20)
        }
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        /*
         能执行的前提是Thread没有销毁并且thread.isFinished == false
         通俗的将就是thread对于的runloop必须是activity
         比如：
         perform(#selector(printThreadMsg), on: Thread(), with: nil, waitUntilDone: false)
         这种写法，printThreadMsg就不会调用，因为Thread直接销毁。
         或者：
         perform(#selector(printThreadMsg), on: tThread, with: nil, waitUntilDone: false)
         tThread只是全局引用，但是没有runloop支持thread不finished。
         
         履行审批手续、委托招标代理公司、编制招标文件、发布招标公告、（资格预审公告，资格预审文件5天)资格预审（购买招标文件）、
         开标、评标、中标签订合同（履约保证金不超过合同价10%）、终止招标。
         
         投标保证金 2% 80万‘
         可以有标底，但是一定要保密。
         国有资金的项目必须设置最高限价，有最高限价的必须要在招标文件中明确最高限价和计算方法。
         国有资金的项目应当设置工程量清单。
         
         投标保证金、履约保证金、质量保证金、工资保证金
         
         大型或者结构复杂的可以使用联合体投标的方式投标。
         
         联合体投标中标后应该共同签订合同，并且就中标项目负连带责任。
         
         同意专业组成的联合体按低资质的算。
         
         招标人应该在招标公告、资格预审公告、招标邀请中载明是否接受联合体。
         
         联合体参加资格预审后，联合体增减、人员变动，其投标无效。
         
         联合体成员单独又投标了该项目那么投标均无效。
         
         属于串标（事实已经发生）和视为串标（没有发生）的理解
         
         */
         perform(#selector(printThreadMsg), on: tTread, with: nil, waitUntilDone: false)
        
        // 该方法能执行,是因为thread默认是当前线程。
        // perform的好处是可以指定方法在哪个线程中执行。
        // perform(#selector(printThreadMsg))
        // perform(#selector(printThreadMsg), on: Thread.main, with: nil, waitUntilDone: false)
        
    }
}

extension SSRunloopVC {
    
    // 开启的线程
    @objc func openThread() {
        autoreleasepool {
            print("start open thread")
            let runloop = RunLoop.current
            runloop.add(NSMachPort(), forMode: .common)
            runloop.run()
            print("end open thread")
        }
    }
    
    // 线程开启，同时内部开启一个runloop，使thread不立即销毁。
    @objc func runloopBtnClick() {
        //tTread.start()
    }
    
    @objc func closeRunloopClick() {
        
        let naviItem = UINavigationItem(title: "new 测试")
        naviItem.rightBarButtonItem = UIBarButtonItem(title: "右边",
                                                      style: .plain,
                                                      target: self,
                                                      action: #selector(printThreadMsg))
        
        // 不允许这样操作。 其item只是暴露出来让，controller来进行控制修改。
        // navigationController?.navigationBar.pushItem(naviItem, animated: true)
        
        
    }
    
    // 打印信息
    @objc func printThreadMsg() {
        print(Thread.current)
        print(tTread.isFinished)
    }
}
