//
//  SSMvvmView.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/1/17.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit

class SSMvvmView: UIView {
    lazy var tableView: UITableView = {
        let tableV = UITableView(frame: CGRect.zero, style: .plain)
        tableV.rowHeight = 46
        tableV.tableFooterView = UIView()
        return tableV
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
