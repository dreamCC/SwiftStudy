//
//  GitHubApi.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2021/1/14.
//  Copyright © 2021 Zhu ChaoJun. All rights reserved.
//

import UIKit
import Moya


let gitHubApi = MoyaProvider<GitHubApi>()

///----------------------------------------------------------------------------
enum GitHubApi {
    // 所有仓促
    case repositories(String)
}


extension GitHubApi {
    
    var parames:[String:Any]? {
        switch self {
        case .repositories(let input):
            return [
                "q": input,
                "sort": "stars",
                "order": "desc"
            ]
        }
    }
}

extension GitHubApi: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    var path: String {
        switch self {
        case .repositories:
            return "/search/repositories"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case .repositories:
            return .requestParameters(parameters: parames!, encoding: URLEncoding.default)
        }
    }
}
