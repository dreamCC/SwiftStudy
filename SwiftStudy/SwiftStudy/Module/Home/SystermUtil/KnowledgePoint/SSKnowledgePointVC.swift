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
    "UniversalLinks","UnsafePoint","KVcKvo","HitTestAndPointInside","Appearance",
    "ModalPresentVc","AddChirldController", "Runloop","SizeThatFits","Countainer", "Extentsion", "UIBezierPath",
    "Arithmetic", "idfa"]
    

    
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
        }else if indexPath.row == 9 {
            navigationController?.pushViewController(SSHitTestAndPointInsideVC(), animated: true)
        }else if indexPath.row == 10 {
            navigationController?.pushViewController(SSAppearanceVC(), animated: true)
        }else if indexPath.row == 11 {
            navigationController?.pushViewController(SSModalPresentVC(), animated: true)
        }else if indexPath.row == 12 {
            navigationController?.pushViewController(SSAddChirldControllerVC(), animated: true)
        }else if indexPath.row == 13 {
            navigationController?.pushViewController(SSRunloopVC(), animated: true)
        }else if indexPath.row == 14 {
            navigationController?.pushViewController(SSSizeThatFitsVC(), animated: true)
        }else if indexPath.row == 15 {
            navigationController?.pushViewController(SSCountainerVC(), animated: true)
        }else if indexPath.row == 16 {
            navigationController?.pushViewController(SSExtentsionViewController(), animated: true)
        }else if indexPath.row == 17 {
            navigationController?.pushViewController(UIBezelPathViewController(), animated: true)
        }else if indexPath.row == 18 {
            navigationController?.pushViewController(SSArithmeticViewController(), animated: true)
        }else if indexPath.row == 19 {

            navigationController?.pushViewController(IdfaViewController(), animated: true)
        }
    }
    
    
    
    
}

