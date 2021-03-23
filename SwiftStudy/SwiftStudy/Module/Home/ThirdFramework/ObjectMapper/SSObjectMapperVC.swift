//
//  SSObjectMapperVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2019/12/31.
//  Copyright © 2019 Zhu ChaoJun. All rights reserved.
//

import UIKit
import ObjectMapper

class SSObjectMapperVC: SSBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        
    }
    
    /*
     从使用上来看，显然，ObjectMapper虽然能将字典转模型，但是使用起来麻烦。
     
     */
    @IBAction func jsonToModel(_ sender: UIButton) {
        let dic:[String:Any] = ["name":"David", "age":18]
        let obj = Mapper<ObjectMapperModel>().map(JSON: dic)
        print(obj!.name, obj!.age)
    }
    
    @IBAction func modelToJson(_ sender: UIButton) {
        let model = ObjectMapperModel(JSON: ["name":"David", "age":18])
        print(model!.toJSONString(prettyPrint: true) ?? "")

        print(model?.name, model?.age)
        
    }
}

class ObjectMapperModel: Mappable {
    
    var name: String = ""
    var age: Int = 0
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
    }
}
