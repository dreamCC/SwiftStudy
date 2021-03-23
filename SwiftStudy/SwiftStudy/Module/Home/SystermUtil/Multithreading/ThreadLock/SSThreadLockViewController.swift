//
//  SSThreadLockViewController.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/11/16.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit

/*
 线程锁的理解：我们常用的是互斥锁，所谓的互斥锁就是当锁释放前，调用锁的lock方法是会阻塞的。
 线程锁一般成对出现。关锁/开锁。
 1、self.nsLock.lock()
    代码块1
    self.nsLock.unLock()
 
 2、self.nsLock.lock()
    代码块2
    self.nsLock.unLock()
 
 比如上面1、2两个线程并发执行代码块1和代码块2。由于是同一个锁self.nsLock。那么线程2中self.nsLock会阻塞（因为获取不到锁），只有当线程1中sef.nsLock.unLock()
    执行完毕后（释放锁），线程2才会执行代码块2中的代码。
 
 
 
 */
class SSThreadLockViewController: SSBaseViewController {


    private lazy var dataSources: [Int] = {
        var ary = [Int]()
        for index in 0..<50 {
            ary.append(index)
        }
        return ary
    }()
    
    // ---- synchoronized。递归锁？
    private lazy var threadSynchronizedA: Thread = {
        let thread = Thread(target: self, selector: #selector(synchronizedRemove), object:nil)
        thread.name = "threadSynchronizedA"
        return thread
    }()
    private lazy var threadSynchronizedB: Thread = {
        let thread = Thread(target: self, selector: #selector(synchronizedRemove), object:nil)
        thread.name = "threadSynchronizedB"
        return thread
    }()

    // ---- nslock。遵循了NSLocking协议。
    private lazy var lock: NSLock = NSLock()
    private lazy var threadNSLockA: Thread = {
        let thread = Thread(target: self, selector: #selector(synchronizedRemove), object:nil)
        thread.name = "threadNSLockA"
        return thread
    }()
    private lazy var threadNSLockB: Thread = {
        let thread = Thread(target: self, selector: #selector(synchronizedRemove), object:nil)
        thread.name = "threadNSLockB"
        return thread
    }()
    
    // --- dispathch_semephore_t。信号量，也可以控制并发数量。
    private lazy var semephore = DispatchSemaphore(value: 1)
    private lazy var threadSemephoreA: Thread = {
        let thread = Thread(target: self, selector: #selector(semephoreRemove), object:nil)
        thread.name = "threadSemephoreA"
        return thread
    }()
    private lazy var threadSemephoreB: Thread = {
        let thread = Thread(target: self, selector: #selector(semephoreRemove), object:nil)
        thread.name = "threadSemephoreB"
        return thread
    }()
    
    /*
     --- NSCondition。 同样是遵循了NSLocking协议，有条件的锁，顾名思义就是当满足某种条件的时候才枷锁。
     wait() 阻塞当前线程。 类似信号量中的wait。
     signal()通知释放第一阻塞的线程。类似信号量中的signal。
     broadcast() 释放每个线程中的第一个阻塞。
     */
    private lazy var nsCondition = NSCondition()
    
    
    /*
     --- NSConditionLock。同样是遵循了NSLocking协议。
     相对于NSCondition来说，可以设置锁的条件condition。
     */
    private lazy var nsConditionLock = NSConditionLock(condition: 0)
    
    /*
     --- NSRecursiveLock。同样是遵循了NSLocking协议。
     递归锁一般在递归函数中使用，递归调用开始后会重复执行此方法以至于反复执行加锁代码最终造成死锁，使用递归锁可以在一个线程中反复获取锁而不造成死锁，
     在这个过程中也会记录获取锁和释放锁的次数，只有等两者平衡的时候才会释放。
     主要是为了防止使用NSLock在进行递归的时候，只加锁而没有释放锁导致死锁的现象。
     */
    private lazy var recursiveLock = NSRecursiveLock()
    
    /*
     互斥锁。
     1、需要进行初始化。pthread_mutex_init
        pthread_mutex_lock 加锁方法。
        pthread_mutex_unlock 解锁方法。
     2、需要释放锁结构。pthread_mutex_destroy
     */
    private var pthreadMutex = pthread_mutex_t()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 互斥锁初始化。
        pthread_mutex_init(&pthreadMutex, nil)
        
    }
    
    @IBAction func synchronized(_ sender: Any) {
        resetDatasources()
        threadSynchronizedA.start()
        threadSynchronizedB.start()
    }
    
    @IBAction func nslock(_ sender: Any) {
        resetDatasources()
        threadNSLockA.start()
        threadNSLockB.start()
    }
    
    @IBAction func semaphore(_ sender: Any) {
        resetDatasources()
        threadSemephoreA.start()
        threadSemephoreB.start()
    }
    
    @IBAction func nscondition(_ sender: Any) {
        dataSources.removeAll()
        DispatchQueue.global().async {
            
            self.nsCondition.lock()
            print("线程1：\(Thread.current)-开始")

            sleep(3)
            if self.dataSources.count == 0 {
                self.nsCondition.wait()
            }
            print("获取到当前数据：\(self.dataSources.first ?? -1000)")
            self.nsCondition.unlock()
            print("线程1：\(Thread.current)-结束")
        }
        
        DispatchQueue.global().async {
            self.nsCondition.lock()
            print("线程2：\(Thread.current)-开始")
            self.dataSources.append(1)
            self.nsCondition.signal()
            self.nsCondition.unlock()
            print("线程2：\(Thread.current)-结束")

        }
    }
    
    @IBAction func nsconditionlock(_ sender: Any) {
        dataSources.removeAll()
        DispatchQueue.global().async {
            self.nsConditionLock.lock(whenCondition: 0)
            
            self.nsConditionLock.unlock(withCondition: 1)
            
        }
        
        DispatchQueue.global().sync {
            self.nsConditionLock.lock(whenCondition: 1)
            
            
            self.nsConditionLock.unlock(withCondition: 0)
        }
        
        
    }
    
    @IBAction func nsrecursivelock(_ sender: Any) {
        resetDatasources()
        recursiveLockFunc()
    }
    
    @IBAction func pthread(_ sender: Any) {
        
        resetDatasources()
        DispatchQueue.global().async {
            pthread_mutex_lock(&self.pthreadMutex)
            for _ in 0..<25 {
                self.dataSources.removeLast()
            }
            pthread_mutex_unlock(&self.pthreadMutex)
        }
        
        DispatchQueue.global().async {
            pthread_mutex_lock(&self.pthreadMutex)
            for index in 0..<25 {
                self.dataSources.append(index)
            }
            pthread_mutex_unlock(&self.pthreadMutex)
        }
    
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("当前数据：\(dataSources)")

    }
    
    deinit {
        pthread_mutex_destroy(&pthreadMutex)
    }
}

extension SSThreadLockViewController {
    
    
    private func resetDatasources() {
        dataSources.removeAll()
        for index in 0..<50 {
            dataSources.append(index)
        }
    }
    
    @objc private func synchronizedRemove() {
        
        var counts = 0
        objc_sync_enter(self)
        while dataSources.count > 0 && counts < 50 {
            counts += 1
            dataSources.removeLast()
            print("count::::\(dataSources.count):\(Thread.current)")
        }
        objc_sync_exit(self)
    }
    
    @objc private func nslockRemove() {
        var counts = 0
        if lock.try() {
            lock.lock()
        }
        defer {
            lock.unlock()
        }
        while dataSources.count > 0 && counts < 50 {
            counts += 1
            dataSources.removeLast()
            print("count::::\(dataSources.count):\(Thread.current)")
        }
    }
    
    @objc private func semephoreRemove() {
        var counts = 0
        semephore.wait()
        while dataSources.count > 0 && counts < 50 {
            counts += 1
            dataSources.removeLast()
            print("count::::\(dataSources.count):\(Thread.current)")
        }
        semephore.signal()
    }
    
    @objc private func nsconditionRemove() {
        var counts = 0
        nsCondition.lock()
        while dataSources.count > 0 && counts < 50 {
            counts += 1
            dataSources.removeLast()
            print("count::::\(dataSources.count):\(Thread.current)")
        }
        nsCondition.unlock()
    }
    
    
    private func recursiveLockFunc() {
        
        recursiveLock.lock()
        
        if dataSources.count > 0 {
            print("移除数据：\(dataSources.last)")
            dataSources.removeLast()
            // 递归函数
            recursiveLockFunc()
        }
        
        recursiveLock.unlock()
    }
}
