//
//  SkeletonViewController.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2021/5/18.
//  Copyright © 2021 Zhu ChaoJun. All rights reserved.
//

import UIKit
import SkeletonView

class SkeletonViewController: UIViewController {

    private lazy var imageV: UIImageView = {
        let imgV = UIImageView(image: UIImage(named: "timg-2"))
        imgV.contentMode = .scaleAspectFit
        imgV.isSkeletonable = true
        return imgV
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        

        
        view.addSubview(imageV)
        imageV.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(200)
        }
        
//        imageV.showSkeleton()
//        imageV.showGradientSkeleton()
//        imageV.showSkeleton(usingColor: UIColor.purple, transition: SkeletonTransitionStyle.crossDissolve(1))
//        imageV.showAnimatedSkeleton()
//        imageV.showAnimatedGradientSkeleton()  // 渐变
        
    
        view.isSkeletonable =  true
        view.showAnimatedSkeleton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
     
        imageV.hideSkeleton()
    }

}
