//
//  SSAlamofireVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2019/12/25.
//  Copyright © 2019 Zhu ChaoJun. All rights reserved.
//

import UIKit
import SnapKit


class SSThirdFrameworkVC: SSBaseViewController {

    lazy var datas = ["Alamofire","HandyJson","SwiftJson","ObjectMapper","Moya","QMUI", "RxSwift", "Kingfisher", "MJRefresh", "R", "SkeletonView", "---"]
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        navigationItem.title = "ThirdFramework"

        datas.reverse()
        
        let tabV = UITableView()
        tabV.delegate = self
        tabV.dataSource = self
        tabV.tableFooterView = UIView()
        view.addSubview(tabV)
        tabV.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
     
        
    }
   
    
    deinit {
        print("deinit=========")

    }

}

extension SSThirdFrameworkVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "cellID"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
        cell?.textLabel?.text = datas[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dataValue = datas[indexPath.row]
        switch dataValue {
        case "Alamofire":
            navigationController?.pushViewController(SSAlamofireVC(), animated: true)
        case "HandyJson":
            navigationController?.pushViewController(SSHandyJsonVC(), animated: true)
        case "SwiftJson":
            navigationController?.pushViewController(SSSwiftJsonVC(), animated: true)
        case "ObjectMapper":
            navigationController?.pushViewController(SSObjectMapperVC(), animated: true)
        case "Moya":
            navigationController?.pushViewController(SSMoyaVC(), animated: true)
        case "QMUI":
            navigationController?.pushViewController(SSQMUIViewController(), animated: true)
        case "RxSwift":
            navigationController?.pushViewController(SSRxViewController(), animated: true)
        case "Kingfisher":
            navigationController?.pushViewController(SSKingfisherViewController(), animated: true)
        case "MJRefresh":
            navigationController?.pushViewController(SSMJRefreshViewController(), animated: true)
        case "R":
            navigationController?.pushViewController(RViewController(), animated: true)
        case "SkeletonView":
            navigationController?.pushViewController(SkeletonViewController(), animated: true)
        default:
           
            let fisher = SSKingfisherViewController()
            print(fisher.name)

            return
        }
    
    }
}
