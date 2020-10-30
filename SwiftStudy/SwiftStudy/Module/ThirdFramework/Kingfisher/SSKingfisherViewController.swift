//
//  SSKingfisherViewController.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/10/28.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit
import Kingfisher

class SSKingfisherViewController: QMUICommonViewController {

    @IBOutlet weak var imageV: UIImageView!
        
    override func viewDidLoad() {
        super.viewDidLoad()

      
        //kingfisherImageSources()
        //kingfisherPlaceHolder()
        kingfisherAllParameters()
        
        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last ?? "为空-", NSHomeDirectory())

    
    
    }
    
    

    private func kingfisherUrl() {
        
        guard let url = URL(string: "http://mvimg2.meitudata.com/55fe3d94efbc12843.jpg") else {
                  print("url 初始化失败")
                  return
        }
              
        imageV.kf.setImage(with: url)
    }

    private func kingfisherImageSources() {
        
        guard let url = URL(string: "http://mvimg2.meitudata.com/55fe3d94efbc12843.jpg") else {
                  print("url 初始化失败")
                  return
        }

        let imageSources = ImageResource(downloadURL: url, cacheKey: "cache_key")
        imageV.kf.setImage(with: imageSources)
    
    }
    
    private func kingfisherPlaceHolder() {
        
        guard let url = URL(string: "https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3245371152,3456791010&fm=26&gp=0.jpg") else {
                  print("url 初始化失败")
                  return
        }
        
        let placeHolder = UIImage(named: "icon_moreOperation_shareMoment")
    
        imageV.kf.setImage(with: url, placeholder: placeHolder)
        
    }
    
    private func kingfisherAllParameters() {
        
        guard let url = URL(string: "https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3245371152,3456791010&fm=26&gp=0.jpg") else {
                  print("url 初始化失败")
                  return
        }
        
       let placeHolder = UIImage(named: "icon_moreOperation_shareMoment")
        imageV.kf.indicatorType = .activity
        imageV.kf.setImage(with: url, placeholder: placeHolder,
                           progressBlock: { (recive: Int64, totoal: Int64) in
                            
                            print(recive/totoal);
        })

        
        
    }
    
    

    
    deinit {
        
        // 清空缓存
        ImageCache.default.clearDiskCache()
        ImageCache.default.clearMemoryCache()
    }

}

extension Kingfisher where Base : UIImageView {
    
    func setImage(with imageUrl: String) {
        
        guard let url = URL(string: imageUrl) else {
            return
        }
        
        setImage(with: url)
    }
    
}


protocol S {
    
    var name: String { get }
    
}

class A: S {
    
    var name: String {
        return ""
    }
    
    
    lazy var age: String = "age"
}
