//
//  RxDataSourcesViewController.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2021/1/16.
//  Copyright © 2021 Zhu ChaoJun. All rights reserved.
//

import UIKit

class RxDataSourcesViewController: UIViewController {

    private let disposBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()

        let tableV = UITableView(frame: .zero, style: .plain)
        tableV.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableV)
        tableV.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        let items = Observable.just(
            [
                SectionModel<String, String>.init(model: "", items: [
                    "hello",
                    "world"
                ])
            ]
        )
        
        let dataSources = RxTableViewSectionedReloadDataSource<SectionModel<String,String>> { (datasources, tv, indexPath, element) -> UITableViewCell in
        
                let cell = tv.dequeueReusableCell(withIdentifier: "Cell")!
                cell.textLabel?.text = "\(indexPath.row)：\(element)"
                return cell
        }
        
        
        items.bind(to: tableV.rx.items(dataSource: dataSources)).disposed(by: disposBag)
        
    }

}
