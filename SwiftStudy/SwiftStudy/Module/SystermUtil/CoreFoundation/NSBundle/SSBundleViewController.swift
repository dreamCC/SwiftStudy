//
//  SSBundleViewController.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/11/1.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit



/*
 Users/zhuchaojun/Library/Developer/CoreSimulator/Devices/B4FFF821-591E-43FA-BCDD-60415BB93DB3/data/Containers/Bundle/Application/C3D17CDB-6878-4795-B0FC-147AE66C9827/SwiftStudy.app
 我们通过Bundle.main.bundlePath获取的就是包名。打印结果如上。
 其实我们可以在项目/products/xxx.app中找到当前生成的app。
 说白了NSBundle.main其实就是我们的生成app的内容。
 比如该项目，通过xxx.app显示包内容是可以展示全部内容的。如下。
 
 _CodeSignature
 Assets.car
 mine.bundle
 Base.lproj
 Frameworks
 Info.plist
 manifest.plist
 PkgInfo
 SSErrorVC.nib
 SSGenericityVC.nib
 SSHandyJsonVC.nib
 SSKingfisherViewController.nib
 SSKvcKvoVC.nib
 SSMoyaVC.nib
 SSObjectMapperVC.nib
 SSPointVC.nib
 SSProgressVC.nib
 SSProtocolVC.nib
 SSRuntimeVC.nib
 SSRxSwiftViewController.nib
 SSRxTableViewVC.nib
 SSSwiftJsonVC.nib
 SSTraitsObservableVC.nib
 SSUniversalLinksVC.nib
 summary
 summary-one-build
 SwiftStudy
 zh-Hans.lproj
 
 我们会发现：
 1、程序中所有的资源文件都是直接在该目录先的。
 2、项目中的bundle文件，是作为整体存放在xxx.app中的。
 3、项目中所有的xib文件都会生成对应的.nib文件。
 4、项目中Assets.xcassets会生成Assets.car文件。
    其实这也是我们使用UIImage.imageContentOfFile获取不到Assets.xcassets的原因。
    因为imageContentOfFile需要获取的是全路径地址。
 
 */
class SSBundleViewController: SSBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


        let  bundle = Bundle.main
        print(bundle.bundlePath)

        let value = bundle.path(forResource: "考试结果 - 产品组测试平台", ofType: "webarchive")
        print(value)
        
        let image = UIImage(named: "timg-2.jpeg")
    
        print(image)
    
        let image2 = UIImage(contentsOfFile: bundle.path(forResource: "timg-2.jpeg", ofType: nil)!)
        print(image2) // imageContentOfFile只能通过bundle获取全路径来加载。
        
        let image3 = UIImage(contentsOfFile: "icon_nav_about")
        print(image3)
            
        
    
        
    
    }
    


}
