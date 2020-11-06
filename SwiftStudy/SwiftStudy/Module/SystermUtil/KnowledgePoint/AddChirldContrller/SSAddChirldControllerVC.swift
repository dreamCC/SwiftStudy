//
//  SSAddChirldControllerVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/6/12.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit
import SnapKit
import WebKit


/*
 
 当我们不使用navigationController.pushxxx 或者 self.presentViewControlelrxxxx的时候，我们想要显示一个控制器管理的view，那么
 会面临几个问题。
 1、如果我们通过self.view.add(vc.view)那么view将不会响应事件。
 2、shouldAutomaticallyForwardAppearanceMethods控制着是否调用viewWillAppeara等系列方法。当通过present或者pushxx的时候，该属性不起作用。
 

 当我们使用addView来添加带控制器的view的时候，我们最好的办法是调用通过: （其实就是容器vc）
 self.addChirld(modalVc)
 self.viwe.add(modalVc.view)来进行显示，不然没法相应事件。
 modalV.didMoveToparent() // 因为只通过上面两步添加，是不会调用modalV的didMoveToParent方法。

 vc.willMoveToparaent:nil // 因为只通过下面两个方法，是不会调用vc的willMoveToparent方法。
 vc.view.remoeFromSuperView
 vc.remoeFromparent
 
 navigationController.pushxxxx。会将controller添加到naviagation.chirldControllers里面。
    被push的控制器会调用willMoveTo和didMoveToParent方法。
 present。并不会调用addChirld方法，所以willMoveTo和didMoveToParent方法不会调用。

 当我们调用navigationController.pushxxxx的时候会有完整过程：
 具体调用顺序:
 willMoveToParent:
 viwWillAppear:
 viewDidAppear:
 didMoveToParent:

 想要做一个容器类控制器，需要的步骤。
 
 */
class SSAddChirldControllerVC: QMUICommonViewController {

    var addWindow: UIWindow!
    override func initSubviews() {
        
        let addBtn = UIButton(type: .system)
        addBtn.setTitle("添加按钮", for: .normal)
        addBtn.addTarget(self, action: #selector(addBtnClick), for: .touchUpInside)
        view.addSubview(addBtn)
        addBtn.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            
        }
        
        let tranAnimation = UIButton(type: .system)
        tranAnimation.setTitle("动画transition", for: .normal)
        tranAnimation.addTarget(self, action: #selector(tranAnimationClick), for: .touchUpInside)
        view.addSubview(tranAnimation)
        tranAnimation.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(addBtn.snp.bottom).offset(20)
        }
    }
    
    @objc func addBtnClick() {
       
        //showUseWindow()
//        showUseAddSubView()
        showUserAddVC()
    }
    
    @objc func tranAnimationClick() {
        
        let first = self.children.first
        let last  = self.children.last
        self.transition(from: first!, to: last!, duration: 1.0, options: .repeat, animations: {
            
        }, completion: nil)
        
    }
    
    func showUseWindow() {
        let addVc = SSChirldForAddVC()
        addVc.view.frame = CGRect(x: 10, y: 100, width: 200, height: 200)

        addWindow = UIWindow()
        addWindow.frame = UIScreen.main.bounds
        addWindow.rootViewController = addVc
        addWindow.makeKeyAndVisible()
    }
    
    func showUseAddSubView() {
        let addVc = SSChirldForAddVC()
        //        self.addChild(addVc)
        addVc.view.frame = CGRect(x: 10, y: 100, width: 200, height: 200)
        //        addVc.beginAppearanceTransition(true, animated: true)
        // view.addSubview(addVc.view)
        //        addVc.endAppearanceTransition()
        self.present(addVc, animated: true, completion: {
            print(self.children)
        })
//        self.navigationController?.pushViewController(addVc, animated: true)
    }
           
    

    func showUserAddVC() {
        


        var first: SSChirldForAddVC!
        for index in 0..<3 {
        
            let addVc = SSChirldForAddVC(index: index)
            addVc.view.frame = CGRect(x: 10, y: 100, width: 200, height: 200)
            self.addChild(addVc)
            if index == 0 {
                first = addVc
            }

        }
        self.view.addSubview(first.view)

        // 只调用上面两个方法，下面的这个方法是不会调用的
        first.didMove(toParent: self)
    }
    

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        print(self.presentedViewController)
        print(self.presentationController, separator: "*", terminator: "--")
        
        let first = self.children.first
        let last  = self.children.last
        self.transition(from: last!, to: first!, duration: 1.0, options: .repeat, animations: {
            
        }, completion: nil)
        
    }
    
    
}

class SSChirldForAddVC: UIViewController {
    
    var index: Int = 0
    convenience init(index: Int) {
        self.init()
        self.index = index
    }
    
    override var shouldAutomaticallyForwardAppearanceMethods: Bool {
        get {
            return false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        print("\(index):viewDidLoad")
        
        view.backgroundColor = UIColor.qmui_random()
        
        let centerBtn = UIButton(type: .system)
        centerBtn.setTitle("中间按钮\(index)", for: .normal)
        centerBtn.addTarget(self, action: #selector(centerBtnClick), for: .touchUpInside)
        view.addSubview(centerBtn)
        centerBtn.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            
        }
    }
    
    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        print("\(index):willMove--", view.frame)
        
    }
    
    
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        print("\(index):didMove--", view.frame)
        
    }
 
    @objc func centerBtnClick() {
        print("\(index):centerBtnClick-Click")
        
        removUserAddVc()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("\(index):touchesBegan-Click")

    }
    
    
    func removUserAddVc() {
        self.willMove(toParent: nil) // 只调用下面两个方法，该方法是不会调用的。
        self.view.removeFromSuperview()
        self.removeFromParent()  // 从父parent.chirldren中移除，这一步是很重要的。
        //self.dismiss(animated: true, completion: nil)
        //self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("\(index):viewWillAppear-")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("\(index):viewDidAppear-")

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("\(index):viewWillDisappear-")
    }
    
    deinit {
        print("\(index):对象销毁--------")
    }
}


extension SSChirldForAddVC: UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning{
    
    // 转场动画的时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    
    // 进行转场动画的实现。
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    }
    
    
    
 
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    
   
}

