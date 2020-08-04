//
//  SSMvvmViewModel.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/1/17.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit

class SSMvvmViewModel: NSObject {

    var datas: Array<SSVMModel> = []
    
    func requestData(sucess: @escaping ()->())  {
        
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 5.0) {
            
            for i in 0..<10 {
                let model = SSVMModel()
                model.name = "--\(i)"
                self.datas.append(model)
            }
            sucess()
            
        }
    }
    
    
}

extension SSMvvmViewModel: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: SSMvvmTableCell = tableView.dequeueReusableCell(
            withIdentifier: "cellId",
            for: indexPath) as! SSMvvmTableCell
        return cell
        
    }
    
}
