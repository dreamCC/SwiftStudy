//
//  SSMvvmVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/1/17.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit
import SnapKit

/*
 
 mvc和mvvm的区别。
 mvc: model、view、controller。困境就是，controller的代码很多（因为对于数据处理没有好的办法）。 而且view和model
    会出现耦合现象（常见UITableviewCell绑定model，通过setModel进行赋值）。
 
 mvvm: model、view(相当于以前的vc)、vm（用于处理数据逻辑）。
    
 */
class SSMvvmVC: UIViewController {
    
    lazy var viewModel: SSMvvmViewModel = SSMvvmViewModel()
    var bodyV: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .reply,
                                                            target: self,
                                                            action: #selector(refreshStart))
        
        let bodyV = SSMvvmView(frame: CGRect.zero)
        view.addSubview(bodyV)
        bodyV.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        bodyV.tableView.delegate = viewModel
        bodyV.tableView.dataSource = viewModel
        bodyV.tableView.register(SSMvvmTableCell.self, forCellReuseIdentifier: "cellId")
        self.bodyV = bodyV.tableView
        
    }


    @objc func refreshStart() {
        viewModel.requestData(){[weak self] in
            DispatchQueue.main.async(execute: {
                self!.bodyV.reloadData()
            })
        }
    }
    
    deinit {
        print("---对象释放")
    }
    
}
