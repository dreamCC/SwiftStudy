//
//  SSModalPresentVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/6/11.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit


/*
 
 我们可以使用pushViewController进行控制器间的切换。
 modal时候有两个重要属性来控制控制器间的转场：
 modalPresentStyle和modalTranstionStyle两个控制着转场的各种系统样式。
 modalPresentStyle    控制着转场结果样式。比如fullScreen、formSheet、PageSheet等结果
 modalTransitionStyle 控制着动画。比如filpHorize、crossDissolve等效果
 
 当使用modal的时候，并不会调用willMoveToParent和didMoveToParent方法。所以我们可以猜想的是，内部并没有调用addChirldController方法。
 
 */
class SSModalPresentVC: QMUICommonViewController, UIViewControllerTransitioningDelegate {

    
    override func initSubviews() {
        
        let modalBtn = QMUIButton(type: .custom)
        modalBtn.setTitle("modalBtn", for: .normal)
        modalBtn.addTarget(self, action: #selector(modalBtnClick), for: .touchUpInside)
        view.addSubview(modalBtn)
        modalBtn.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
    }

    @objc func modalBtnClick() {
        let modaledVc = ModaledViewController()
        modaledVc.modalPresentationStyle = .currentContext
        modaledVc.modalTransitionStyle   = .flipHorizontal
        //modaledVc.transitioningDelegate = self
        self.definesPresentationContext = true
        modaledVc.preferredContentSize = CGSize(width: 200, height: 50)
        
        self.present(modaledVc, animated: true, completion: nil)

     

    }
    
    
    override var shouldAutomaticallyForwardAppearanceMethods: Bool {
        get {
            return true
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touches began")
    }
    
    
}


class ModaledViewController: UIViewController {
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSubviews()
    }
    
     func initSubviews() {
        
        view.backgroundColor = UIColor.qmui_random()
        
    
        let modalBtn = QMUIButton(type: .custom)
        modalBtn.setTitle("modalBtn", for: .normal)
        modalBtn.addTarget(self, action: #selector(modalBtnClick), for: .touchUpInside)
        view.addSubview(modalBtn)
        modalBtn.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    
    }
    
   
    
    @objc func modalBtnClick() {
        
        dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.next?.touchesBegan(touches, with: event)
    }
    
    
}
