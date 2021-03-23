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

    // 释放池
    private let disposeBag = DisposeBag()
    
    override func initSubviews() {
        super.initSubviews()
        dataSouces = ["Observable", "Observer", "Subjects", "Operator", "Trail",
        "Schedulers","RxDataSources"]
        
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
        let selecteValue = dataSouces[indexPath.row]
        switch selecteValue {
        case "Observable":
            navigationController?.pushViewController(ObservableViewController(), animated: true)
        case "Observer":
            navigationController?.pushViewController(ObserverViewController(), animated: true)
        case "Subjects":
            navigationController?.pushViewController(SubjectsViewController(), animated: true)
        case "Operator":
            navigationController?.pushViewController(OperatorViewController(), animated: true)
        case "Trail":
            navigationController?.pushViewController(TrailViewController(), animated: true)
        case "Schedulers":
            navigationController?.pushViewController(SchedulersViewController(), animated: true)
        case "RxDataSources":
            navigationController?.pushViewController(RxDataSourcesViewController(), animated: true)
        default:
            print("--------")
        }
        
        
    }
}

