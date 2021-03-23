//
//  SSMultithreadingVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/4/22.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit

class SSMultithreadingVC: UIViewController {
    

    
    let datas = ["Thread","GCD","OperationQueue","ThreadLock"]
    

    override func viewDidLoad() {
        super.viewDidLoad()

    
        
    
        navigationItem.title = "多线程"
        
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

extension SSMultithreadingVC: UITableViewDelegate, UITableViewDataSource {
    
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
            navigationController?.pushViewController(SSThreadVC(), animated: true)
        }else if indexPath.row == 1 {
            navigationController?.pushViewController(SSGCDVC(), animated: true)
        }else if indexPath.row == 2 {
            navigationController?.pushViewController(SSOperationVC(), animated: true)
        }else if indexPath.row == 3 {
            navigationController?.pushViewController(SSThreadLockViewController(), animated: true)
        
        }

       

    }
}

