//
//  SSAlamofireVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2019/12/25.
//  Copyright © 2019 Zhu ChaoJun. All rights reserved.
//

import UIKit
import SnapKit


class SSThirdFrameworkVC: UIViewController {

    lazy var datas = ["Alamofire","HandyJson","SwiftJson","ObjectMapper","Moya","QMUI"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        navigationItem.title = "ThirdFramework"

        let tabV = UITableView()
        tabV.delegate = self
        tabV.dataSource = self
        tabV.tableFooterView = UIView()
        view.addSubview(tabV)
        tabV.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        
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
        if indexPath.row == 0 {
            
            navigationController?.pushViewController(SSAlamofireVC(), animated: true)
        }else if indexPath.row == 1{
            navigationController?.pushViewController(SSHandyJsonVC(), animated: true)
        }else if indexPath.row == 2{
            navigationController?.pushViewController(SSSwiftJsonVC(), animated: true)
        }else if indexPath.row == 3{
            navigationController?.pushViewController(SSObjectMapperVC(), animated: true)
        }else if indexPath.row == 4{
            navigationController?.pushViewController(SSMoyaVC(), animated: true)
        }else if indexPath.row == 5{
            navigationController?.pushViewController(SSQMUIViewController(), animated: true)
        }
    }
}
