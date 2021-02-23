//
//  SSGCDVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2019/12/24.
//  Copyright © 2019 Zhu ChaoJun. All rights reserved.
//

import UIKit
import SnapKit

class SSGCDVC: UIViewController {
    
  
    
    var workItem: DispatchWorkItem!
    var semaphore: DispatchSemaphore = DispatchSemaphore(value: 3)

    var timer: DispatchSourceTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        navigationItem.title = "GCD"
        
        
        let desLab = UITextView()
        desLab.font = UIFont.systemFont(ofSize: 16)
        desLab.text = "GCD中，常见的概念同步、异步，串行和并发。同步和异步的本质区别是：是否会开启新的线程，比如我们在主线程中调用DispathQueue.globle.sync{ }。 那么执行的还是在主线程中。我们可以理解，当开启同步，那么当前线程会阻塞，然后立即去执行提交的同步代码，直到执行完成后，再去执行阻塞的线程任务，这也是串行对象中，开启同步线程出现死锁的原因。DispathQueue表示队列。通过queue.async或者queue.sync来开启线程。\n\n1、初始化。DispatchQueue.main、DispatchQueue.globle()获取系统提供的主队列和异步并发队列。\n\n2、DispatchQueue(label: \"com.barrier.cn\", qos: .default, attributes: [.concurrent, .initiallyInactive], autoreleaseFrequency: .never, target: nil)。该方法的几个属性。\n\nlable: 标识。\n\nqos：服务质量，也就是优选级，如果不设置就是默认default。userInteractive 、userInitiated 、default、utility、background。\n\nattributes: 选项集合。有两个值concurrent表示并发，initiallyInactive标识是否手动触发，如果设置该标识，那么队列需要通过queue.activity（）来手动触发。注意这个参数默认[] 标识串行队列自动触发。\n\nautoreleaseFrequency: 用来管理{}内对象的生命周期的。就是autorealea pool的释放频率。有三个值inherit：继承目标队列的该属性。workItem：跟随每个任务的执行周期进行自动创建和释放never：不会自动创建 autorelease pool，需要手动管理。 一般使用workItem，当然如果有大量重复对象，可以使用never, 然后我们自己创建自动释放池。\n\ntarget： 设置的队列的目标队列。即队列中的任务运行的实际队列。注意：我们手动创建的队列，最后都是添加到系统的主队列和全局队列中。 该参数默认是nil。 我们可以传DispathQueue.main(这个时候创建的就是主队列)、DisPathQueue.globle。\n\n3、barrier栅栏。注意栅栏是通过WorkItem的flage进行标记，同时queue必须通过init的形式创建。\n\n4、DispathWorkItem，其实是用来帮助DispathQueue执行任务的。 其常用方法workItem.perform()、workItem.cancel()、workItem.notify、workItem.wait() 是会阻塞当前线程的。执行完后进入该方法。已经运行的workItem是无法取消的。\n\n5、DispathGroup的使用。参考Demo，其实和oc的使用是一样的。\n\n6、DispatchTime一般配合queue.asyAfter使用，延时操作。"
        view.addSubview(desLab)
        desLab.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-50)
        }
        
        //gcdFunc()
        gcdBarrierFunc()
        //gcdTargetFunc()
        //gcdWorkItemFunc()
        //gcdGroupFunc()
        //gcdTimeFunc()
        //gcdSemaphoreFunc()
        
    }
    
    func gcdFunc() {
        
    
        // 系统提供了一个串行队列，一个并发队列。
        let main = DispatchQueue.main
        let globle = DispatchQueue.global()
        
       
        main.async {
            print("main:",Thread.current)
        }
        
        globle.async {
            print("globle-async1:", Thread.current)
        }
        globle.async {
            print("globle-async2:", Thread.current)
        }
        globle.async {
            print("globle-async3:", Thread.current)
        }
        globle.async {
            print("globle-async4:", Thread.current)
        }
        
        // 同步和异步
        globle.sync {
            print("globle-sync1:", Thread.current)
        }
        globle.sync {
            print("globle-sync2:", Thread.current)
            
        }
        globle.sync {
            print("globle-sync3:", Thread.current)
        }
        //globle-sync1: <NSThread: 0x600002fe9a00>{number = 1, name = main}
        //globle-sync2: <NSThread: 0x600002fe9a00>{number = 1, name = main}
        //globle-sync3: <NSThread: 0x600002fe9a00>{number = 1, name = main}
        
        // 我们需要将线程和队列区分开来。线程是由队列开启的。
        
     
    }
    
    // Swift GCD实现栅栏
    func gcdBarrierFunc() {
        
        // 设置并发队列，如果attributes: 不设置，那么就是串行队列。 initiallyInactive是否手动触发。concurrent并发队列。
        
        // 属性： lable: 标识。
        // qos：服务质量，也就是优选级。userInteractive 、userInitiated 、default、utility、background
        // attributes: 选项集合。有两个值concurrent表示并发，initiallyInactive标识是否手动触发，如果设置该标识，那么就需要调用        queue.activate()来手动触发队列。。
        // autoreleaseFrequency: 用来管理{}内对象的生命周期的。就是autorealea pool的释放频率。
        // target： 设置的队列的目标队列。即队列中的任务运行的实际队列。注意：我们手动创建的队列，最后都是添加到系统的主队列和全局队列中。 该参数默认是nil。 我们可以传DispathQueue.main(这个时候创建的就是主队列)、DisPathQueue.globle
        let queue = DispatchQueue(label: "com.barrier.cn", qos: .default, attributes: [.concurrent, .initiallyInactive], autoreleaseFrequency: .inherit, target: nil)

        
        let workItem = DispatchWorkItem(qos: .userInitiated, flags: .barrier) {
            print("---------------barrier", Thread.current)
        }
        
        
        queue.async(execute: DispatchWorkItem(block: {
            sleep(2)
            print("globle-async1:", Thread.current)
        }))
        queue.async(execute: DispatchWorkItem(block: {
            sleep(2)
            print("globle-async2:", Thread.current)
        }))
        
        queue.async(execute: workItem)
        
        queue.async(execute: DispatchWorkItem(block: {
            sleep(2)
            print("globle-async3:", Thread.current)
        }))
        queue.async(execute: DispatchWorkItem(block: {
            sleep(2)
            print("globle-async4:", Thread.current)
        }))
     
        // 如果queue设置attributes 有.initiallyInactive则表示需要手动触发。
        queue.activate()
        
        
    }
    
    func gcdTargetFunc() {
        //target： 设置的队列的目标队列。即队列中的任务运行的实际队列。注意：我们手动创建的队列，最后都是添加到系统的主队列和全局队列中。 该参数默认是nil。 我们可以传DispathQueue.main(这个时候创建的就是主队列)、DisPathQueue.globle
        let queue = DispatchQueue(label: "com.target.cn",  attributes: .concurrent, autoreleaseFrequency: .workItem, target: DispatchQueue.main)
        
        queue.async {
            print("gcdTarget", Thread.current) // 发现打印的是主队列。
        }
    }
    
    func gcdWorkItemFunc()  {
        // workItem 可以直接执行。workItem.perform()、workItem.cancel()。这个时候线程任务所在队列就是，该执行语句所在队列。
        // 我们也可以直接借助DispathQueue来进行执行。DispatchQueue.global().async(execute: workItem)
        workItem = DispatchWorkItem {
            for index in 0..<10 {
                sleep(1)
                if self.workItem.isCancelled {
                    break
                }
                print("workItem: 执行|\(index)",Thread.current)
            }
        }
        
    
        // 执行完后，会调用该方法。
        workItem.notify(queue: DispatchQueue.main) {
            print("=============workItem: 执行结束",Thread.current)
        }
        
        // DispathWorkItem的核心是可以封装一个闭包，该闭包可以有workItem.perform（）来执行，
        // 也可以交由Queue队列来进行调度。
         DispatchQueue.global().async(execute: workItem)
        // workItem.perform()

        //_ = self.workItem.wait() // 该方法是会阻塞当前线程的，类似sleep
        print("=============workItem: 开始执行",Thread.current)

    }

    
    func gcdGroupFunc() {
        
        let queue = DispatchQueue.global()
        let group = DispatchGroup()
        
        queue.async(group: group) {
            sleep(1)
            print("=============group1",Thread.current)
        }
        queue.async(group: group) {
            sleep(1)
            print("=============group2",Thread.current)
        }
        queue.async(group: group) {
            sleep(1)
            print("=============group3",Thread.current)
        }
        group.notify(queue: DispatchQueue.main) {
            print("=============group: 执行结束",Thread.current)
            
        }
        
    }
    
    
    func gcdTimeFunc() {
        
        timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
        timer!.schedule(deadline: .now(), repeating: 1)
        timer!.setEventHandler {
            print("定时器启动：\(Thread.current)")
        }
        timer!.resume()
    }
    
    
    func gcdSemaphoreFunc() {
        print("start")
        let semaphore = DispatchSemaphore(value: 0)
        DispatchQueue.global().async {
            Thread.sleep(forTimeInterval: 2)
            semaphore.signal()
            print("signal-start")
        }
        
        
        semaphore.wait()
        print("end")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      
        workItem.cancel() // 是无法对运行的任务进行取消的。 但是可以标记为取消，我们需要通过isCanceled来获取是否取消
        
    }
    
    deinit {

    }
    
    
}
