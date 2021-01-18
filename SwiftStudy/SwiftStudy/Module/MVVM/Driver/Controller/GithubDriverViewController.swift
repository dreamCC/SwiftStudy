//
//  GithubDriverViewController.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2021/1/16.
//  Copyright © 2021 Zhu ChaoJun. All rights reserved.
//

import UIKit

class GithubDriverViewController: UIViewController {

    
    private let disposeBag = DisposeBag()
    
    private var vm: GitHubDriverViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let observer = Observable<Int>.of(1)
            .flatMap({ (value) -> Observable<Int> in
                print("zhi-z")
                return Observable<Int>.create { (observer) -> Disposable in
                    print("zhi-z==")

                    DispatchQueue.global().async {
                        observer.onNext(value)
                    }
                    return Disposables.create()
                }
            }).asDriver(onErrorJustReturn: 1)
    
        observer.drive { (varlu) in
            print("---", Thread.current)
        }.disposed(by: disposeBag)

        observer.drive { (varlu) in
            print("---", Thread.current)
        }.disposed(by: disposeBag)
        
        //didInitialize()
        
        
    }
    
    private func didInitialize() {
        
    
        
        let tableView = UITableView(frame: CGRect.zero, style: UITableView.Style.plain)
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        searchBar.barStyle = .default
        tableView.tableHeaderView = searchBar
    
        
        // 初始化vm
        vm = GitHubDriverViewModel(searchAction: searchBar.rx.text.orEmpty.asObservable())
        vm.repositories.drive(tableView.rx.items) { (tableView, row, element) in
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
            cell.textLabel?.text = element.name
            cell.detailTextLabel?.text = element.fullName
            return cell
            }.disposed(by: disposeBag)
    }
  
    deinit {
        print("deinit 调用")
    }
}

