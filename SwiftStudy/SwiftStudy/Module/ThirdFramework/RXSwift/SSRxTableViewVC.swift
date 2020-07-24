//
//  SSRxTableViewVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/7/17.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class SSRxTableViewVC: QMUICommonViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var dataSources: Observable<[String]> = {
        return Observable.just([
            "文本输入框的用法",
            "开关按钮的用法",
            "进度条的用法",
            "文本标签的用法",
        ])
    }()
    private let kCellId = "kCellId"
    private let disposeBag = DisposeBag()
    
    override func initSubviews() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.qmui_back(withTarget: self, action: #selector(rightBarButtonItemClick))
        
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: kCellId)
        
        
    }
 
    
    @objc func rightBarButtonItemClick() {
        tableView.setEditing(!tableView.isEditing, animated: true)
    }

    deinit {
        print("销毁了----------")
    }

}

extension SSRxTableViewVC {
    
    func normalFunc() {
        dataSources
            .bind(to: tableView.rx.items) {[weak self] (tableView, row, element) in
                guard let `self` = self else {
                    return  UITableViewCell()
                }
                let cell = tableView.dequeueReusableCell(withIdentifier: self.kCellId)!
                cell.textLabel?.text = "\(row)：\(element)"
                return cell
        }
        .disposed(by: disposeBag)
        
        
        tableView.rx.itemSelected.subscribe { (event: Event<IndexPath>) in
            print("当前点击",event.element)
        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(String.self).subscribe { (event: Event<String>) in
            print("当前点击数据：", event.element)
        }.disposed(by: disposeBag)
        
        
        tableView.rx.itemDeleted
            .subscribe(onNext: {[weak self] (indexPath: IndexPath) in
                guard let `self` = self else {
                    return
                }
                print("当前删除", indexPath)
                
                
            }).disposed(by: disposeBag)
        
        tableView.rx.itemMoved
            .subscribe(onNext: { (event: ItemMovedEvent) in
                print(event.sourceIndex, event.destinationIndex)
            }).disposed(by: disposeBag)
    }
    
    func rxDataSources() {
        
    }
}
