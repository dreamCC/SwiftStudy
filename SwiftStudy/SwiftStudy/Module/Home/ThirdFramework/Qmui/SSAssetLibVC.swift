//
//  SSAssetLibVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/6/18.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit

/*
 PHAssetCollection, 对应的是一个相册。有三种类型album（新建相册）、samartAblum（系统自带相册）
 PHAsset，对应的每个相片资源。
 
 获取相册通过PHCachingImageManager。当然我们可以通过QMUIAsset来直接获取。其内部就是通过PHCachingImagemanage来获取图片
 
 同样QMUIAssetManager管理相册的权限。
 QMUIAsset，对应的相片资源。
 QMUIAssetGroup，对应的相册资源。
 
 
 */

class SSAssetLibVC: QMUICommonViewController {

    
  
    override func initSubviews() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.qmui_item(withTitle: "右边",
                                                                      target: self,
                                                                      action: #selector(rightBtnClick))
        navigationItem.rightBarButtonItem?.qmui_badgeInteger = 12
        
     
        
        let assetCollection = QMUIButton()
        assetCollection.setTitle("AssetCollection", for: .normal)
        assetCollection.addTarget(self, action: #selector(assetCollectionClick), for: .touchUpInside)
        view.addSubview(assetCollection)
        assetCollection.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        let asset = QMUIButton()
        asset.setTitle("AssetClick", for: .normal)
        asset.addTarget(self, action: #selector(assetClick), for: .touchUpInside)
        view.addSubview(asset)
        asset.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(assetCollection.snp.bottom).offset(20)
        }
        
    }

    @objc func rightBtnClick() {
        
        print(PHPhotoLibrary.authorizationStatus().rawValue)
        
        // 获取相册，通过PHCacheingImage
    }
}

extension SSAssetLibVC {
    
    @objc func assetCollectionClick() {
        
        let  result: PHFetchResult<PHAssetCollection> = PHAssetCollection.fetchAssetCollections(
            with: .smartAlbum,
            subtype: .any,
            options: nil)
        
        result.enumerateObjects { (collcetion, index, point) in
            print("SmartAblum",collcetion.localizedTitle)
        }
        
        let  result1: PHFetchResult<PHAssetCollection> = PHAssetCollection.fetchAssetCollections(
            with: .album,
            subtype: .any,
            options: nil)
        
        result1.enumerateObjects { (collcetion, index, point) in
            print("album",collcetion.localizedTitle)
        }
        
        
    }
    
    @objc func assetClick() {
        
    }
    
}
