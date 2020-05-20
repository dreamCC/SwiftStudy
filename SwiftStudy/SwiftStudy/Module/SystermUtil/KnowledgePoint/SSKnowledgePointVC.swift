//
//  SSKnowledgePointVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/4/22.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit

class SSKnowledgePointVC: UIViewController {
    
    let datas = ["KeyWords","Function","Range","Runtime","JsonModel","Progress",
    "UniversalLinks","UnsafePoint","KVcKvo"]
    

    
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


}

extension SSKnowledgePointVC: UITableViewDelegate, UITableViewDataSource {
    
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
            navigationController?.pushViewController(SSKeyWordVC(), animated: true)
        }else if indexPath.row == 1 {
            navigationController?.pushViewController(SSFunctionVC(), animated: true)
        }else if indexPath.row == 2 {
            navigationController?.pushViewController(SSRangeVC(), animated: true)
        }else if indexPath.row == 3 {
            navigationController?.pushViewController(SSRuntimeVC(), animated: true)
        }else if indexPath.row == 4 {
            //navigationController?.pushViewController(SSJsonModelVC(), animated: true)
        }else if indexPath.row == 5 {
            navigationController?.pushViewController(SSProgressVC(), animated: true)
        }else if indexPath.row == 6 {
            navigationController?.pushViewController(SSUniversalLinksVC(), animated: true)
        }else if indexPath.row == 7 {
            navigationController?.pushViewController(SSPointVC(), animated: true)
        }else if indexPath.row == 8 {
            navigationController?.pushViewController(SSKvcKvoVC(), animated: true)
        }
    }
    
    
    
    
}
