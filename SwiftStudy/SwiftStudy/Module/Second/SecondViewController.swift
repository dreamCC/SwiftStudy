//
//  SecondViewController.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2021/3/9.
//  Copyright © 2021 Zhu ChaoJun. All rights reserved.
//

import UIKit

class SecondViewController: UITableViewController {

    private var dataSources: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSources = ["xcConfig", "mvp", "mvvm", "metadata"]
    
        tableView.tableFooterView = UIView()
    }
    
}

extension SecondViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSources.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "cellId"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
        cell!.textLabel?.text = dataSources[indexPath.row]
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectStr = dataSources[indexPath.row]
        switch selectStr {
        case "xcConfig":
            navigationController?.pushViewController(XcConfigViewController(), animated: true)
        case "mvp":
            navigationController?.pushViewController(MvpViewController(), animated: true)
        case "mvvm":
            navigationController?.pushViewController(MvvmViewController(), animated: true)
        case "metadata":
            navigationController?.pushViewController(MetadataViewController(), animated: true)
        default:
            return
        }
    }
}
