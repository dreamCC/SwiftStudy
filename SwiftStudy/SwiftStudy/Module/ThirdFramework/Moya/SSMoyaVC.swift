//
//  SSMoyaVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/1/14.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit
import Moya

/*
 关于Moya使用细节：
 首选有两个协议TargetType、MoyaProviderType两个协议方法。 遵循两个协议方法，才能进行网络请求。
 
 1、TargetType协议。
    几个重要属性。 baseUrl、path、method等。其中sampleDate在我们进行单元测试的时候自动返回设置的测试数据，
        这样在服务器接口没有完成的情况下也能调用网络请求。。
    包括一个extension validationType，返回码校验，默认是.none。
 
 2、MultiTarget遵循了TargetType协议。 这是为了处理当有多个Targe的时候，防止创建多个MoyaProvider。
    provider.request(MultiTargetType(.loginxxx))
 
 */


class SSMoyaVC: SSBaseViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleName = "Moya"
      
        
        
    }

    
    @IBAction func moyaBtnClick(_ sender: UIButton) {
        
        let login: SSUserAPI = .login("", "")
        networkProvider.request(login) { (result) in
            switch result {
            case .success(let response):
            
                print(response)
            case .failure(let error):
                print(error)
            }
        }
        
        SSNetworkManager.request(login, success: { (response) in
            print(response)
        }) { (error) in
            print(error)
        }
       
    }
    
    @IBAction func multiTargetTypeClick(_ sender: UIButton) {
        
        let login: SSUserAPI = .login("", "")


        let moyaProvider = MoyaProvider<SSUserAPI>(endpointClosure: { (target) -> Endpoint in
            return MoyaProvider<SSUserAPI>.defaultEndpointMapping(for: target)
        })
        moyaProvider.request(login) { (result) in
            print(result)
        }
        
        let moyaProvider2 = MoyaProvider<SSUserAPI>(requestClosure: { (endPoint, requesResultCloseSure) in
            
            do {
                let urlRequest = try endPoint.urlRequest()
                requesResultCloseSure(.success(urlRequest))
            } catch MoyaError.requestMapping(let url) {
                requesResultCloseSure(.failure(MoyaError.requestMapping(url)))
            } catch MoyaError.parameterEncoding(let error) {
                requesResultCloseSure(.failure(MoyaError.parameterEncoding(error)))
            } catch {
                requesResultCloseSure(.failure(MoyaError.underlying(error, nil)))
            }
            
        })
        
        moyaProvider2.request(login) { (result) in
            
            print(result)
        }
        
        
    }
}

