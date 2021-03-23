//
//  SSOperationViewController.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/4/22.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit


/*
 Operation和Oprationqueue的关系，其实和Dispathqueue和DispathchWorkItem的关系很像。
 
 OperationQueue().addOperations来添加线程，而OperationQueue像一个线程池，或者是队列。
 OprationQueue的优势在于能够控制并发数量，cancleAllOprations等操作。
 
 而Opration.cancel其实和DispathWorkItem.cancle一样，只是表示当前线程为cancled状态，具体我们
 还是需要通过opration.isCancled 或者 workItem.isCancled来进行判断，进而进行一些特殊操作。
 只有OprationQueue才能进行线程的取消。
 
 线程锁。类似oc中@synchorized(self) {}
 objc_sync_enter(self)
 
 objc_sync_exit(self)
 
 */
class SSOperationVC: SSBaseViewController {

    
    var blockOp: BlockOperation!
    var opQueue: OperationQueue!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleName = "OperationQueue"

        //operationFunc()
        blockOpration()
        
    
    }
    
    private func operationFunc() {
        
        OperationQueue.main.addOperation {
            print("main,OperationQueue", Thread.current)
        }
        
        OperationQueue().addOperation {
            print("asys,OperationQueue", Thread.current)
        }
        

        
    }
  
    private func blockOpration() {
        blockOp = BlockOperation {
            print("blockOP-init", Thread.current)
        }
        blockOp.addExecutionBlock { [weak self] in
            for i in 0..<20 {
                sleep(1)
                print("执行\(i)", Thread.current)
                if self!.blockOp.isCancelled {
                    break
                }
            }
        }
        blockOp.completionBlock = {
            print("complemention")
        }
       
        opQueue = OperationQueue()
        
        //这三种方式都能启动线程。如果直接start，那么初始化的block就会在当前线程中执行。
        //blockOp.start()
        //OperationQueue.main.addOperation(blockOp)
        opQueue.addOperation(blockOp)

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //blockOp.cancel()
        opQueue.cancelAllOperations()
    }

}
