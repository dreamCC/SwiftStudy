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
    var tRunloop: RunLoop!
    var timer: Timer!

    
    override func didInitialize() {
        super.didInitialize()
        
    }
    
    override func initSubviews() {
        title = "runloop"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "👉",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(printThreadMsg))
        
        let runloopBtn = QMUIButton()
        runloopBtn.setTitle("startRunLoop", for: .normal)
        runloopBtn.addTarget(self, action: #selector(startRunloopBtnClick), for: .touchUpInside)
        view.addSubview(runloopBtn)
        runloopBtn.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }

        let closeRunloop = QMUIButton()
        closeRunloop.setTitle("closeRunloop", for: .normal)
        closeRunloop.addTarget(self, action: #selector(closeRunloopBtnClick), for: .touchUpInside)
        view.addSubview(closeRunloop)
        closeRunloop.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(runloopBtn.snp.bottom).offset(20)
        }

        let testRunloop = QMUIButton()
        testRunloop.setTitle("testRunloop", for: .normal)
        testRunloop.addTarget(self, action: #selector(testRunloopBtnClick), for: .touchUpInside)
        view.addSubview(testRunloop)
        testRunloop.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(closeRunloop.snp.bottom).offset(20)
        }

        let testTimer = QMUIButton()
        testTimer.setTitle("testTimer", for: .normal)
        testTimer.addTarget(self, action: #selector(testTimerBtnClick), for: .touchUpInside)
        view.addSubview(testTimer)
        testTimer.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(testRunloop.snp.bottom).offset(20)
        }
    }
    

    deinit {
        timer?.invalidate()
    }

}

extension SSRunloopVC {
    
    // 开启的线程
    @objc func openThread() {

        
        autoreleasepool {
            print("start open thread", Thread.current)
            let runloop = RunLoop.current
            tRunloop = runloop
            runloop.add(NSMachPort(), forMode: .common)
            runloop.run()
            print("end open thread", Thread.current)
        }
    }
    
    // 线程开启，同时内部开启一个runloop，使thread不立即销毁。
    @objc func startRunloopBtnClick() {
        tTread = Thread(target: self, selector: #selector(openThread), object: nil)
        tTread.name = "current-"
        tTread.start()
    }
    
    @objc func closeRunloopBtnClick() {
    
        
        tTread.cancel()
    
    }
    
    
    @objc func testRunloopBtnClick() {
        /*
         能执行的前提是Thread没有销毁并且thread.isFinished == false
         通俗的将就是thread对于的runloop必须是activity
         比如：
         perform(#selector(printThreadMsg), on: Thread(), with: nil, waitUntilDone: false)
         这种写法，printThreadMsg就不会调用，因为Thread直接销毁。
         或者：
         perform(#selector(printThreadMsg), on: tThread, with: nil, waitUntilDone: false)
         tThread只是全局引用，但是没有runloop支持thread不finished。
         */
        
         perform(#selector(printThreadMsg), on: tTread, with: nil, waitUntilDone: false)
        
        // 下面方法能执行,是因为thread默认是当前线程。
        // perform的好处是可以指定方法在哪个线程中执行。
        // perform(#selector(printThreadMsg))
        // perform(#selector(printThreadMsg), on: Thread.main, with: nil, waitUntilDone: false)
        // Thread.detachNewThreadSelector(#selector(printThreadMsg), toTarget: self, with: nil)
        
    }
    
    @objc func testTimerBtnClick() {
        
        timer = Timer(timeInterval: 1, repeats: true, block: { (timer) in
            print("计时器开始", Thread.current)
            if self.tTread.isCancelled {
                Thread.exit()
            }
                
        })
        tRunloop.add(timer, forMode: .default)
        timer.fire()
        
    }
    
    // 打印信息
    @objc func printThreadMsg() {
        print(Thread.current)
        print("tTread.isFinished:",tTread.isFinished)
        print("tTread.isExecuting:",tTread.isExecuting)
        print("tTread.isCancelled:",tTread.isCancelled)

    }
    
}
