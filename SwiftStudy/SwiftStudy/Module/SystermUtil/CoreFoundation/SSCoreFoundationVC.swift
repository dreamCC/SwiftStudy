//
//  SSCoreFoundationVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/4/22.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit

class SSCoreFoundationVC: UIViewController {
    

    let datas = ["Enum","String","Array","OptionSet","AnyAnyObject","Notifycation",
    "CharacterSet","Protocol","Genericity","Error","URLComponents","Tuples"]
 

    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "常见类型"
        
        let tabV = UITableView()
        tabV.dataSource = self
        tabV.delegate   = self
        tabV.tableFooterView = UIView()
        view.addSubview(tabV)
        tabV.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }

    
       @objc func ttest() {
           print("-------ttest")
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
        if indexPath.row == 0 {
            navigationController?.pushViewController(SSEnumVC(), animated: true)
        }else if indexPath.row == 1 {
            navigationController?.pushViewController(SSStringVC(), animated: true)
        }else if indexPath.row == 2 {
            navigationController?.pushViewController(SSArraryVC(), animated: true)
        }else if indexPath.row == 3 {
            navigationController?.pushViewController(SSOptionSetVC(), animated: true)
        }else if indexPath.row == 4 {
            navigationController?.pushViewController(SSAnyAnyObjectVC(), animated: true)
        }else if indexPath.row == 5 {
            navigationController?.pushViewController(SSNotifycationVC(), animated: true)
        }else if indexPath.row == 6 {
            navigationController?.pushViewController(SSCharacterSetVC(), animated: true)
        }else if indexPath.row == 7 {
            navigationController?.pushViewController(SSProtocolVC(), animated: true)
        }else if indexPath.row == 8 {
            navigationController?.pushViewController(SSGenericityVC(), animated: true)
        }else if indexPath.row == 9 {
            navigationController?.pushViewController(SSErrorVC(), animated: true)
        }else if indexPath.row == 10 {
            navigationController?.pushViewController(SSURLComponentsVC(), animated: true)
        }else if indexPath.row == 11 {
            navigationController?.pushViewController(SSTuplesVC(), animated: true)
        }


    }
    
    
   
}



