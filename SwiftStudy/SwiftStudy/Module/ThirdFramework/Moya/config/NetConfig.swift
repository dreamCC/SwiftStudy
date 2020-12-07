//
//  NetConfig.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/12/1.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import Moya


let baseUrl = "http://39.100.146.105:7001"


extension TargetType {
    
    var baseURL: URL {
        return URL(string: baseUrl)!
    }
    
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    // 验证队列。
    var validationType: ValidationType {
        return .successCodes
    }
}

// 增加私有方法
private extension String {
    var urlEscaped: String {
    
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
    }
    
}


extension MoyaProvider {
    
    
    
}
