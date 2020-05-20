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

class SSSystermUtilVC: UIViewController {
    

    let datas = ["Multithreading","CoreFoundation","KnowledgePoint","UserInterfaceStyle",""]
    
   

    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "系统知识"
        
        let tabV = UITableView()
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
        if indexPath.row == 0 {
            navigationController?.pushViewController(SSMultithreadingVC(), animated: true)
        }else if indexPath.row == 1 {
            navigationController?.pushViewController(SSCoreFoundationVC(), animated: true)
        }else if indexPath.row == 2 {
            navigationController?.pushViewController(SSKnowledgePointVC(), animated: true)
        }else if indexPath.row == 3 {
            navigationController?.pushViewController(SSUserInterfaceStyleVC(), animated: true)
            
            let vc = SSUserInterfaceStyleVC()
            vc.modalPresentationStyle = .custom
            vc.transitioningDelegate  = self
            present(vc, animated: true, completion: nil)
        }else {
            print(SSSystermUtilVC.self, type(of: self))
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
