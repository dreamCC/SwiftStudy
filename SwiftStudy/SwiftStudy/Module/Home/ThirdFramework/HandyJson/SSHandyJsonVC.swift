//
//  SSHandyJsonVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2019/12/31.
//  Copyright © 2019 Zhu ChaoJun. All rights reserved.
//

import UIKit
import HandyJSON

class SSHandyJsonVC: SSBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        titleName = "HandyJson"
    }

    @IBAction func jsonToModel(_ sender: UIButton) {
        let jsonString = "{\"name\":\"David\",\"age_id\":12}"
        if let modle = HandyJsonModel.deserialize(from: jsonString) {
            print(modle.name, modle.age)
        }
        
    }
    
    @IBAction func modelToJson(_ sender: UIButton) {
        
        let model = HandyJsonModel()
        model.name = "Lucy"
        model.age = 18
        print(model.toJSONString(prettyPrint: true) ?? "")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {

    }
}


class NotHandyJSONType {
    var dummy: String?
}

class HandyJsonModel: HandyJSON {
    
    var name: String = ""
    var age: Int = 0
    
    var notHandyJSONTypeProperty: NotHandyJSONType?
    
    required init() {}
    
    func mapping(mapper: HelpingMapper) {
        // 注意这个写法。固定。映射：
        mapper <<<
            self.age <-- "age_id"
        
        // 如果在Model中存在因为某些原因不能实现HandyJSON协议的非基本字段
        mapper >>> self.notHandyJSONTypeProperty
        
    }
    
    func didFinishMapping() {
        print("you can fill some observing logic here")
    }
    

}


