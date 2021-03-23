//
//  SSSearchResultVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/7/3.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit

class SSSearchResultVC: QMUICommonViewController, UISearchResultsUpdating {

    var dataSources: [String]!
    var searchDataSources: [String] = []

    var tabV: UITableView!
    private let kCellId = "kCellId"

    convenience init(datas: [String]) {
        self.init()
        self.dataSources = datas
    }
    
    override func initSubviews() {
     
        view.backgroundColor = UIColor.qmui_random()
        
        tabV = UITableView()
        tabV.dataSource = self
        tabV.delegate  = self
        tabV.rowHeight = 44
        tabV.tableFooterView = UIView()
        tabV.register(UITableViewCell.self, forCellReuseIdentifier: kCellId)
        tabV.contentInsetAdjustmentBehavior = .never
        view.addSubview(tabV)
        tabV.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
    }

    
    func updateSearchResults(for searchController: UISearchController) {
        guard let str = searchController.searchBar.text else {
            return
        }
        
        searchDataSources.removeAll()
        for item in dataSources {
            let lowItem = item.lowercased()
            if lowItem.range(of: str.lowercased()) != nil {
                searchDataSources.append(item)
            }
        }
        
        tabV.reloadData()
    }
}

extension SSSearchResultVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
           return searchDataSources.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: kCellId, for: indexPath)
            cell.textLabel?.text = searchDataSources[indexPath.row]

           return cell
       }
       
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          
       }
}
