//
//  SSSystermUtilVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2019/12/23.
//  Copyright © 2019 Zhu ChaoJun. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire

class SSSystermUtilVC: SSBaseViewController {
    

    var datas = ["Multithreading","CoreFoundation","KnowledgePoint","UserInterfaceStyle","QuartzAndCoreGraphics","UIWindowScene", "Assembly", "Point", "AirDrop"]
    
   

    let handleDataSouces = SSHandelDataSouces()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        navigationItem.title = "系统知识"
        
        datas.reverse()
        
        let tabV = UITableView()
        
        tabV.qmui_multipleDelegatesEnabled = true
        tabV.dataSource = handleDataSouces
        tabV.dataSource = self
        tabV.delegate = self
        
        tabV.tableFooterView = UIView()
        
        view.addSubview(tabV)
        tabV.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        
        
       
        
    }
    

    


}

extension SSSystermUtilVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "cellId"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
        cell?.textLabel?.text = datas[indexPath.row]
    
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dataValue = datas[indexPath.row]
        switch dataValue {
        case "Multithreading":
            navigationController?.pushViewController(SSMultithreadingVC(), animated: true)
        case "CoreFoundation":
            navigationController?.pushViewController(SSCoreFoundationVC(), animated: true)
        case "KnowledgePoint":
            navigationController?.pushViewController(SSKnowledgePointVC(), animated: true)
        case "UserInterfaceStyle":
            navigationController?.pushViewController(SSUserInterfaceStyleVC(), animated: true)
        case "QuartzAndCoreGraphics":
            navigationController?.pushViewController(SSQuartzAndCoreGraphicsVC(), animated: true)
        case "UIWindowScene":
            navigationController?.pushViewController(SSUIWindowSceneViewController(), animated: true)
        case "Assembly":
            navigationController?.pushViewController(AssemblyViewController(), animated: true)
        case "Point":
            navigationController?.pushViewController(PointViewController(), animated: true)
        case "AirDrop":
            navigationController?.pushViewController(AirDropViewController(), animated: true)
        default:
            return
        }
        
    }
    
    
    
    
}


// 转场动画。
extension SSSystermUtilVC: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        
        return nil
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return nil
    }
    
}

class SSHandelDataSouces: NSObject, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
