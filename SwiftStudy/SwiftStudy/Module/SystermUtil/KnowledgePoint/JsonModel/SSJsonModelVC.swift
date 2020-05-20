//
//  SSJsonVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2019/12/31.
//  Copyright © 2019 Zhu ChaoJun. All rights reserved.
//

import UIKit

class SSJsonModelVC: SSBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        titleName = "Json"
        
        desLab.text = "JSONSerialization用于Aarry或Dictionary与Data间的转换。使用场景：网络请求返回，data类型的数据（可参考URLSession.dataTask），当然，像Alamofire能将data转换成String、Array或Dictionary其中，转换成data转换成Arrary或者Dictionary就需要借助JSONSerialization。当然这一步只是将data转换成数组或者字典，实际开发中我们一般需要将Array或Dictionary转换成Model，这个时候就需要借助JsonEncode和JsonDecode。"

        
        
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        testJsonDecoder()
        //testJsonEncode()
    }
    
}


// JSONSerialization。将Arrary或者Dictionary转成Data。 或将Data转成Array或Dictionary。
extension SSJsonModelVC {
    
    func testJsonSerialization() {
        let obj: [String:Any] = ["name":"David","age":12]
        
        let data = objToJson(obj: obj)
        
        print(data)

        let changeObj = jsonToObj(data: data)
        print(changeObj)
    }
    
    // 注意obj只能是Array或Dictionary。
    func objToJson(obj: Any) -> Data {
        if !JSONSerialization.isValidJSONObject(obj) {
            return Data()
        }
        return try! JSONSerialization.data(withJSONObject: obj, options: JSONSerialization.WritingOptions.prettyPrinted)
    }
    
    // 注意返回值只能Array或Dictionary
    func jsonToObj(data: Data) -> Any {
        do {
           let obj = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
            return obj
        }catch {
            return "error"
        }
    }
}


/// JSONEndcoder和JsonDecoder。
extension SSJsonModelVC {
    
    
    func testJsonDecoder() {
        let dic:[String:Any] = ["name":"David","age":0]
        let obj = dicToModel(dic: dic)
        print(obj.age, obj.name )
        
    }
    
    func testJsonEncode() {
        let model = SystermJsonModel()
        model.name = "David"
        model.age = 12
        print(modelToDic(model: model))
        
    }
    
    
    /*
      使用JsonDecode将data转换成模型需要注意几点：
      1、模型中的类型。是否是可选类型，如果是，那么对dic的要求就很低，有相应的key就能解析。如果不是，那么dic就必须要全部
        包含两种类型的key才可以。
     2、dic的写法注意。并且，模型需要遵循相应的协议。
     */
    func dicToModel(dic:[String: Any]) -> SystermJsonModel {

        let dicData = objToJson(obj: dic)
        let decoder = JSONDecoder()
        do{
            return try decoder.decode(SystermJsonModel.self, from: dicData)
        }catch {
            return SystermJsonModel()
            //return SystermJsonModel(name: "unkonw", age: 0)
        }
    }
    
    /*
     使用JsonEncode将model转换成data。这个限制就很少。只会转回mode里面设置的属性。
     
     */
    func modelToDic(model: SystermJsonModel) -> [String:Any] {
        let coder = JSONEncoder()
        do {
            let data = try coder.encode(model)
            return jsonToObj(data: data) as! [String : Any]
        }catch {
            return Dictionary()
        }
        
    }
}

class SystermJsonModel: Codable {
    var name: String = ""
    var age: Int = 0

}
