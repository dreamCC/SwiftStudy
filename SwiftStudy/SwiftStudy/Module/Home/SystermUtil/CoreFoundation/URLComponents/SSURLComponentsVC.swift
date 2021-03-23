//
//  SSURLComponentsVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2019/12/26.
//  Copyright © 2019 Zhu ChaoJun. All rights reserved.
//

import UIKit

class SSURLComponentsVC: SSBaseViewController {

    var closures:((_ name: String, _ age: Int)->(String, Int))!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.titleName = "URLComponents"
        

        
        closures = { (naem, age)->(String, Int) in
            
            return (naem,age)
        }
        print(closures("david",12))
        
        self.desLab.text = "URLComponents是一个结构体，其主要功能是，我们可以更加方便的来操作url的各个部分。\n\n1、提供了如下方式来修改url的各个部分。scheme、user、password、host、port、path、query、fragment。\n2、同样提供了percentEncodedQuery、percentEncodedPath、percentEncodedHost、percentEncodedUser、percentEncodedPassword、percentEncodedFragment来获取各个部分进行百分号编码的值。"
        
        urlCompontesFunc()
    }
    
    
    func urlCompontesFunc() {
        
        /*
         url: https://johnny:p4ssw0rd@www.example.com:443/script.ext%3Bparam=value?query=value%23ref
         
         host: www.example.com
         user: johnny
         password: p4ssw0rd
         port: 443
         query: query=value#ref
         fragment:
         path: /script.ext;param=value
         
         percentEncodedQuery: query=value%23ref
         percentEncodedPath: /script.ext%3Bparam=value
         percentEncodedHost: www.example.com
         percentEncodedUser: johnny
         percentEncodedPassword: p4ssw0rd
         percentEncodedFragment:
         
         */
        let urlString = "https://johnny:p4ssw0rd@www.example.com:443/script.ext;param=value?query=value&名字=lucy#ref"
        
        guard let urlComponts = URLComponents(string: urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? "") else {
            return
        }
        
    
        print("scheme:", urlComponts.scheme ?? "")
        print("url:", urlComponts.url ?? "")
        print("host:", urlComponts.host ?? "")
        print("user:", urlComponts.user ?? "")
        print("password:", urlComponts.password ?? "")
        print("port:", urlComponts.port ?? "")
        print("query:", urlComponts.query ?? "")
        print("fragment:", urlComponts.fragment ?? "")
        print("path:", urlComponts.path)
        
        

        print("percentEncodedQuery:", urlComponts.percentEncodedQuery ?? "")
        print("percentEncodedPath:", urlComponts.percentEncodedPath )
        print("percentEncodedHost:", urlComponts.percentEncodedHost ?? "")
        print("percentEncodedUser:", urlComponts.percentEncodedUser ?? "")
        print("percentEncodedPassword:", urlComponts.percentEncodedPassword ?? "")
        print("percentEncodedFragment:", urlComponts.percentEncodedFragment ?? "")
    
        
        print(urlComponts)
        print(CharacterSet.urlQueryAllowed)
        
        
    }
    
}


extension SSURLComponentsVC: URLSessionTaskDelegate {
    
}
