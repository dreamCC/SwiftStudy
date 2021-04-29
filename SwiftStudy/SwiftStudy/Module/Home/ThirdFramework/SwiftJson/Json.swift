//
//  Json.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2021/4/21.
//  Copyright © 2021 Zhu ChaoJun. All rights reserved.
//

import UIKit

enum JsonError: Int, Error {
    case invalidJSON = 400
    case indexOutOfBounds = 401
    case wrongType = 402
}


enum JsonType {
    case string
    case array
    case dictionary
    case null
}


struct Json {
    
    fileprivate var rawArray = [Any]()
    fileprivate var rawDictionary = [String:Any]()
    fileprivate var rawString = ""
    fileprivate var rawNull  = NSNull()
    
    fileprivate(set) var type: JsonType = .null
    fileprivate(set) var error: JsonError?
    
    fileprivate(set) var object: Any {
        get {
            switch type {
            case .array:
                return rawArray
            case .dictionary:
                return rawDictionary
            case .string:
                return rawString
            default:
                return rawNull
            }
        }
        set {
            switch newValue {
            case let value as String:
                type = .string
                rawString = value
            case let value as [Any]:
                type = .array
                rawArray = value
            case let value as [String:Any]:
                type = .dictionary
                rawDictionary = value
            default:
                type = .null
                error = JsonError.invalidJSON
            }
        }
    }
    
    init(data: Data, options: JSONSerialization.ReadingOptions = []) throws {
        let jsonObj = try JSONSerialization.jsonObject(with: data, options: options)
        self.init(jsonObject: jsonObj)
    }
    
    init(jsonString: String) throws{
        if  let data = jsonString.data(using: .utf8)  {
            try self.init(data: data)
        }else {
            self.init(jsonObject: NSNull())
        }
        
    }
    
    
    init(_ jsonObject: Any) {
        switch jsonObject {
        case let data as Data:
            do {
                try self.init(data: data)
            }catch {
                self.init(jsonObject: NSNull())
            }
        default:
            self.init(jsonObject: jsonObject)
        }
    }
    
    fileprivate init(jsonObject: Any) {
        object = jsonObject
    }
    
    public static var null: Json { return Json(NSNull()) }
}

enum JsonKey {
    case index(Int)
    case key(String)
}

protocol JsonSubscriptKey {
    var jsonKey: JsonKey { get }
}

extension Int: JsonSubscriptKey {
    var jsonKey: JsonKey {
        .index(self)
    }
}

extension String: JsonSubscriptKey {
    var jsonKey: JsonKey {
        .key(self)
    }
}


extension Json {
    
   fileprivate subscript(index: Int) -> Json {
        set {
            if type == .array,
               rawArray.indices.contains(index),
               newValue.error == nil {
                rawArray[index] = newValue.object
            }
        }
        get {
            if type != .array {
                var j = Json.null
                j.error = self.error ?? JsonError.wrongType
                return j
            }else if(rawArray.indices.contains(index)){
                return Json(rawArray[index])
            }else {
                var j = Json.null
                j.error = self.error ?? JsonError.indexOutOfBounds
                return j
            }
        }
   }
}


