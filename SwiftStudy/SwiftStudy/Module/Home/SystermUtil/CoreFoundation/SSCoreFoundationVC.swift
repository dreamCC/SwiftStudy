//
//  SSCoreFoundationVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/4/22.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit

class SSCoreFoundationVC: UIViewController {
    

    var datas = ["Enum","String","Array","OptionSet","AnyAnyObject","Notifycation",
    "CharacterSet","Protocol","Genericity","Error","URLComponents","Tuples","Animation","UIPropertyAnimator",
    "NSCache", "NSBundle", "Character", "Int", "Sequence","classAndStruct"]
 

    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "常见类型"
        
        // 排序
        datas.reverse()
        
        let tabV = UITableView()
        tabV.dataSource = self
        tabV.delegate   = self
        tabV.tableFooterView = UIView()
        view.addSubview(tabV)
        tabV.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        
        
    }

    
       

}

extension SSCoreFoundationVC: UITableViewDelegate, UITableViewDataSource {
    
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
        case "Enum":
            navigationController?.pushViewController(SSEnumVC(), animated: true)
        case "String":
            navigationController?.pushViewController(SSStringVC(), animated: true)
        case "Array":
            navigationController?.pushViewController(SSArraryVC(), animated: true)
        case "OptionSet":
            navigationController?.pushViewController(SSOptionSetVC(), animated: true)
        case "AnyAnyObject":
            navigationController?.pushViewController(SSAnyAnyObjectVC(), animated: true)
        case "Notifycation":
            navigationController?.pushViewController(SSNotifycationVC(), animated: true)
        case "CharacterSet":
            navigationController?.pushViewController(SSCharacterSetVC(), animated: true)
        case "Protocol":
            navigationController?.pushViewController(SSProtocolVC(), animated: true)
        case "Genericity":
            navigationController?.pushViewController(SSGenericityVC(), animated: true)
        case "Error":
            navigationController?.pushViewController(SSErrorVC(), animated: true)
        case "URLComponents":
            navigationController?.pushViewController(SSURLComponentsVC(), animated: true)
        case "Tuples":
            navigationController?.pushViewController(SSTuplesVC(), animated: true)
        case "Animation":
            navigationController?.pushViewController(SSAnimationVC(), animated: true)
        case "UIPropertyAnimator":
            navigationController?.pushViewController(SSUIViewPropertyAnimatorVC(), animated: true)
        case "NSCache":
            navigationController?.pushViewController(SSNSCacheViewController(), animated: true)
        case "NSBundle":
            navigationController?.pushViewController(SSBundleViewController(), animated: true)
        case "Character":
            navigationController?.pushViewController(SSCharacterViewController(), animated: true)
        case "Int":
            navigationController?.pushViewController(SSIntViewController(), animated: true)
        case "Sequence":
            navigationController?.pushViewController(SSSequenceViewController(), animated: true)
        case "classAndStruct":
            navigationController?.pushViewController(SSClassAndStructVC(), animated: true)
        default:
            return
        }
        

    }
    
    
   
}



