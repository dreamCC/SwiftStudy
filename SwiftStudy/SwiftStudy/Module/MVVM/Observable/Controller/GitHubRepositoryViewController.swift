//
//  SSObservableVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2021/1/14.
//  Copyright © 2021 Zhu ChaoJun. All rights reserved.
//

import UIKit
import RxCocoa


class GitHubRepositoryViewController: UIViewController {

    
    private let disposeBag = DisposeBag()
    
    private var vm: GitHubRepositoryViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        didInitialize()
        
        
    }
    
    private func didInitialize() {
        
    
        
        let tableView = UITableView(frame: CGRect.zero, style: UITableView.Style.plain)
        
        //tableView.delegate = self
        //tableView.dataSource = self
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        searchBar.delegate = self
        searchBar.barStyle = .default
        tableView.tableHeaderView = searchBar
        
//        searchBar.rx.text.orEmpty
//            .filter { !$0.isEmpty }
//            .throttle(.milliseconds(1000), scheduler: MainScheduler.instance)
//            .subscribe {[weak self] (value) in
//                print("subscribe:", value, Date().description)
//                self?.vm.getGitHubRepository(value)
//            } onCompleted: {
//                print("omCompleted")
//            }.disposed(by: disposeBag)

        
        // 初始化vm
        vm = GitHubRepositoryViewModel(searchAction: searchBar.rx.text.orEmpty.asObservable())
        
        vm.repositories.bind(to: tableView.rx.items) { (tableView, row, element) in
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
            cell.textLabel?.text = element.name
            cell.detailTextLabel?.text = element.fullName
            return cell
            }.disposed(by: disposeBag)
        
        // 可以使用driver来避免出现 Observable.onError的情况，但是对于onCompletable还是没法处理，
        // 也就是如果如果出现onCompletable还是会解除绑定。
//        vm.repositories.asDriver(onErrorJustReturn: [])
//            .drive(tableView.rx.items) { (tableView, row, element) in
//            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
//            cell.textLabel?.text = element.name
//            cell.detailTextLabel?.text = element.fullName
//            return cell
//            }.disposed(by: disposeBag)
         

        
        let jsonString = "[{\"name\":\"David\",\"age_id\":12}]"
        let jsonData = jsonString.data(using: .utf8)
        let jsonObj = try! JSONSerialization.jsonObject(with: jsonData!, options: .allowFragments)
        print(type(of: jsonObj))
       
        
        let json = try! JSON(data: jsonData!)
        let name = json[1]["name1"].stringValue
        print("name的值=",name, name.count)
    }
  
    deinit {
        print("deinit 调用")
    }
}

extension GitHubRepositoryViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
}

extension GitHubRepositoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "cellId"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
        cell?.textLabel?.text = "===:\(indexPath.row)"
        return cell!
    }
    
    
    
    
}
