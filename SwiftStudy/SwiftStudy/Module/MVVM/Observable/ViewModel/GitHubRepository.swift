//
//  ObservableModel.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2021/1/14.
//  Copyright © 2021 Zhu ChaoJun. All rights reserved.
//

import Foundation
import ObjectMapper

struct GitHubRespositores: Mappable {

    var totalCount: Int = 0
    var items: [GitHubRepository] = [GitHubRepository]()
    var ag: Int = 0
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        totalCount <- map["total_count"]
        items <- map["items"]
        ag <- map["ag"]
    }
}


struct GitHubRepository: Mappable {

    var name: String!
    var fullName: String!
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        name <- map["name"]
        fullName <- map["full_name"]
    }
}
