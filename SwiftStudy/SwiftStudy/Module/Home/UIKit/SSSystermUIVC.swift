//
//  SSSystermUIVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/6/22.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit

class SSSystermUIVC: QMUICommonTableViewController {

    var dataSources: [String]  = {
        return ["UITableView", "FloatLayoutView","PieProgressView","ViewShowWay","Layer", "SSSearchController",
        "QMUITextField", "QMUITips", "UIPageViewController", "UICollectionViewController", "UIFont", "UIKeyInput"]
    }()
    
    private let kCellId = "kCellId"
    override func initSubviews() {
        super.initSubviews()
        
        // 排序
        dataSources.reverse()
        
        view.backgroundColor = UIColor.white
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
        
        let dataValue = dataSources[indexPath.row]
        switch dataValue {
        case "UITableView":
            navigationController?.pushViewController(SSTableViewController(), animated: true)
        case "FloatLayoutView":
            navigationController?.pushViewController(SSFloatLayoutViewController(), animated: true)
        case "PieProgressView":
            navigationController?.pushViewController(SSProgressViewVC(), animated: true)
        case "ViewShowWay":
            navigationController?.pushViewController(SSViewShowWayController(), animated: true)
        case "Layer":
            navigationController?.pushViewController(SSLayerViewController(), animated: true)
        case "SSSearchController":
            navigationController?.pushViewController(SSSearchControllerVC(), animated: true)
        case "QMUITextField":
            navigationController?.pushViewController(SSTextFieldViewController(), animated: true)
        case "QMUITips":
            navigationController?.pushViewController(SSTipsViewController(), animated: true)
        case "UIPageViewController":
            navigationController?.pushViewController(SSPageViewController(), animated: true)
        case "UICollectionViewController":
            navigationController?.pushViewController(SSCollectionViewController(), animated: true)
        case "UIFont":
            navigationController?.pushViewController(SSUIFontViewController(), animated: true)
        case "UIKeyInput":
            navigationController?.pushViewController(SSUIKeyInputViewController(), animated: true)
        default:
            return
        }
       
    }
    


}
