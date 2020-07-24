//
//  SSRxViewController.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/7/9.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SSRxViewController: QMUICommonTableViewController {

    private var dataSouces: [String]!
    private let kCellId = "kCellId"

    override func initSubviews() {
        super.initSubviews()
        dataSouces = ["RxCocoa", "RxSwift", "TransformOperator", "FilterOperator",
                      "CombingOperator", "ConnectableObservable", "OtherOperator",
                      "TraitsObservable", "Schedulers", "RxTableView"]
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: kCellId)
    }
}


extension SSRxViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSouces.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellId, for: indexPath)
        cell.textLabel?.text = dataSouces[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            navigationController?.pushViewController(SSRxCocoaViewController(), animated: true)
        }else if indexPath.row == 1 {
            navigationController?.pushViewController(SSRxSwiftViewController(), animated: true)
        }else if indexPath.row == 2 {
            navigationController?.pushViewController(SSRxSwiftTransformOperatorVC(), animated: true)
        }else if indexPath.row == 3 {
            navigationController?.pushViewController(SSRxSwiftFilterOperatorVC(), animated: true)
        }else if indexPath.row == 4 {
            navigationController?.pushViewController(SSRxSwiftComBingVC(), animated: true)
        }else if indexPath.row == 5 {
            navigationController?.pushViewController(SSConnectableOperatorsVC(), animated: true)
        }else if indexPath.row == 6 {
            navigationController?.pushViewController(SSOtherOperatorVC(), animated: true)
        }else if indexPath.row == 7 {
            navigationController?.pushViewController(SSTraitsObservableVC(), animated: true)
        }else if indexPath.row == 8 {
            navigationController?.pushViewController(SSSchedulersVC(), animated: true)
        }else if indexPath.row == 9{
            navigationController?.pushViewController(SSRxTableViewVC(), animated: true)
        }
    }
}

