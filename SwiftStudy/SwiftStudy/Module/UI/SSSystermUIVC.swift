//
//  SSSystermUIVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/6/22.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit

class SSSystermUIVC: QMUICommonTableViewController {

    let dataSources: [String]  = {
        return ["UITableView", "FloatLayoutView","PieProgressView","ViewShowWay","Layer", "SSSearchController",
        "QMUITextField", "QMUITips"]
    }()
    
    private let kCellId = "kCellId"
    override func initSubviews() {
        super.initSubviews()
        
        
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: kCellId)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSources.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellId, for: indexPath)
        cell.textLabel?.text = dataSources[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            navigationController?.pushViewController(SSTableViewController(), animated: true)
        }else if indexPath.row == 1 {
            navigationController?.pushViewController(SSFloatLayoutViewController(), animated: true)
        }else if indexPath.row == 2 {
            navigationController?.pushViewController(SSProgressViewVC(), animated: true)
        }else if indexPath.row == 3 {
            navigationController?.pushViewController(SSViewShowWayController(), animated: true)
        }else if indexPath.row == 4 {
            navigationController?.pushViewController(SSLayerViewController(), animated: true)
        }else if indexPath.row == 5 {
            navigationController?.pushViewController(SSSearchControllerVC(), animated: true)
        }else if indexPath.row == 6 {
            navigationController?.pushViewController(SSTextFieldViewController(), animated: true)
        }else if indexPath.row == 7 {
            navigationController?.pushViewController(SSTipsViewController(), animated: true)
        }
    }

}
