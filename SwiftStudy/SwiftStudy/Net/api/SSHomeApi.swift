//
//  SSHomeApi.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/12/1.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import Moya

let homeProvider = MoyaProvider<SSHomeAPI>()

//MARK: -----------
enum SSHomeAPI {
   
    var parameters: [String:Any] {
           switch self {
           case let .list(page: page, token: token):
               return ["page":page, "token": token]
           case .info(id: let id):
               return ["id": id]
           }
       }
    
    case list(page: String, token: String)
    case info(id: String)
}

extension SSHomeAPI: TargetType {
   
    
    var path: String {
        if case .list = self {
            return "/list"
        }
        if case .info = self {
            return "/info"
        }
        return ""
    }
       
    
    var task: Task {
        switch self {
        case .list:
            
            return .requestPlain
        default:
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }
    

    
}
