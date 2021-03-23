//
//  SSSearchControllerVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/7/3.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit

class SSSearchControllerVC: QMUICommonViewController {
    
    let dataSources: [String]  = {
        return ["Hello", "Age","D","put","Layer", "pub"]
    }()
    
    
    private let kCellId = "kCellId"
    
    var tableView: UITableView!
    var searchVc: UISearchController!
    var qmuiSearchVc: QMUISearchController!
    var searchDataSources: [String] = []

    
    override func initSubviews() {
        super.initSubviews()
        
        
        let searResultVc = SSSearchResultVC(datas: self.dataSources)
        searchVc = UISearchController(searchResultsController: searResultVc)
        //searchVc.view.backgroundColor = UIColor.qmui_random()
        searchVc.obscuresBackgroundDuringPresentation = false
        //searchVc.hidesNavigationBarDuringPresentation = false
        self.definesPresentationContext = true
        searchVc.searchResultsUpdater = searResultVc
        searchVc.searchBar.qmui_usedAsTableHeaderView = true
        
//        qmuiSearchVc = QMUISearchController(contentsViewController: self)
//        qmuiSearchVc.searchBar.qmui_usedAsTableHeaderView = true
        
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate   = self
        tableView.dataSource = self
        tableView.rowHeight  = 44
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: kCellId)
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    
        
        
        tableView.tableHeaderView = searchVc.searchBar
        
        //self.navigationItem.searchController = searchVc
        //self.navigationItem.hidesSearchBarWhenScrolling = false
        
        
    }
    
    
  
    
}

extension SSSearchControllerVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if(searchVc.isActive) {
//            return searchDataSources.count
//        }
        return dataSources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellId, for: indexPath)
//        if searchVc.isActive {
//            cell.textLabel?.text = searchDataSources[indexPath.row]
//        }else {
//            cell.textLabel?.text = dataSources[indexPath.row]
//        }
        cell.textLabel?.text = dataSources[indexPath.row]

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
}

extension SSSearchControllerVC: UISearchResultsUpdating {
    
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
        
        tableView.reloadData()
    }
    
}
