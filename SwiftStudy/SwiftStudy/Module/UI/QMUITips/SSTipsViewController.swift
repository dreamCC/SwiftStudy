//
//  SSTipsViewController.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/7/8.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit

class SSTipsViewController: QMUICommonTableViewController {

   let dataSources: [String]  = {
        return ["Loading", "Custom"]
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
            QMUITips.showLoading(in: self.view, hideAfterDelay: 2.0)
        }else if indexPath.row == 1 {
            let tost = QMUIToastView(view: self.view)
            
            
            let backV = QMUIToastBackgroundView()
            backV.shouldBlurBackgroundView = true
            tost.backgroundView = backV
            
            let contV = QMUIToastContentView()
            contV.textLabelText = "Toast"
            tost.contentView = contV
            self.view.addSubview(tost)
            tost.show(animated: true)
        }
    }

}
