//
//  SSSwiftJsonVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2019/12/31.
//  Copyright © 2019 Zhu ChaoJun. All rights reserved.
//

import UIKit
import SwiftyJSON

class SSSwiftJsonVC: SSBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    /*
        其实Swift的缺点就很明显了。也就是我们必须要认为的获取key，并且进行赋值。
     */
    @IBAction func modelToJson(_ sender: UIButton) {
        let dic:[String:Any] = ["age":12]

        let jsonData = JSON(dic)
        let model = SwiftJsonModle(jsonData)
        print(model.name, model.age)
        
    }
    
    // 因为swiftJson，并不是将其转换为model的，只是将相应的值转换为JSON结构体。我们可以很方便的取值。
    // 如果想要转换模型，就必须认为的进行设置。所以就不存在将模型转换为字典。
    @IBAction func jsonToModel(_ sender: UIButton) {
        
    }
    
}


class SwiftJsonModle {
    var name: String
    var age: Int

    init(_ jsonData: JSON) {
        name = jsonData["name"].stringValue
        age = jsonData["age"].intValue
    }
}


