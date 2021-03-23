//
//  SSQMUIViewController.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/6/2.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit

/*
 类的继承关系。
 NSObject基类->UIResponder(接受事件，内部有touchxxx点击事件、motionxxx加速计、remoteControlReceivedWithEvent远程控制)->UIView(显示)->UIControl（addTarge等方法）->UIButton。
 继承自UIResponse的有UIIVew、UIVIewController、UIApplication、AppDelegate。
 
 CALayer直接继承NSObject所以不能接受事件。
 
 
 QMUI是实现的逻辑，1、当QMUITheme.shareInstance.setThemeIdentify的时候，会调用notificyName方法，然后会调用UIview层的quuiThemeDidChangexxxx方法。
 然后在UIView的分类中，会重写获取view的一些属性进行赋值。
 

 */



class SSQMUIViewController: QMUICommonViewController {
    
  
    
    lazy var datas = ["QMUIDispalyLinkAnimation","QMUIAsset",  ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        navigationItem.title = "ThirdFramework"
        
        let tabV = UITableView()
        tabV.delegate = self
        tabV.dataSource = self
        tabV.tableFooterView = UIView()
        view.addSubview(tabV)
        tabV.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }
    
    
}

extension SSQMUIViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "cellID"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
        cell?.textLabel?.text = datas[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            navigationController?.pushViewController(SSDisplayLinkAnimationVC(), animated: true)
        }else if indexPath.row == 1 {
            navigationController?.pushViewController(SSAssetLibVC(), animated: true)
        }else {
            
        }
    }
}



// runtime 增加属性。
extension SSQMUIViewController {
    
    private struct AssociatedKey {
        static var nameKey: String = ""
    }
    
    var name: String {
        set {
            objc_setAssociatedObject(self, &AssociatedKey.nameKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.nameKey) as! String
        }
    }
    
}
