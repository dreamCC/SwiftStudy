//
//  SSAlamofireVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2019/12/25.
//  Copyright © 2019 Zhu ChaoJun. All rights reserved.
//

import UIKit
import Alamofire

/*
 URLSession。初始化。URLsssion.shared、或者通过init设置代理。
 涉及到的一些类。
 回话：URLSession、URLSessionConfig。
 请求任务。URLSessionTask基类。
 子类：URLSessionDataTask（请求）、URLSessionDownloadTask（下载）、URLSessionStreamTask（流）。
 URLSessionUploadTask继承URLSessionDataTask用于上传。
 
 与其像对于的协议有
 会话层：URLSessionDelegate。
 任务层：URLSessionTaskDelegate基协议。
 子协议：URLSessionDataTaskDelegate、URLSessionDownloadTaskDelegate、URLSesssionStreamTaskDelegate。
 
 */
enum SSError: LocalizedError {
    var localizedDescription: String {
        switch self {
        case .noInput:
            return "没有输入"
        default:
            return "没有值"
        }
    }
    
    case noValue
    case noInput
}

/*
 Alamofire。对于请求的封装有几个关键类：Request、DataRequest、DownloadRequest、UploadRequest、StreamRequest。
    在Request.swift文件内。
 Alamofire之所以引入download，因为，默认requset是将返回的数据加载在内容中，如果是大文件就会出现问题，导致内存暴增，所以
 就需要使用download方法。
 
 对于Response的处理，response、responseData、responseString、responseJson、responsePropertyList几个方法，这几个方法都是Request类或者其子类提供的方法。 这几个方法在ReponseSerialization.swift文件内，通过extension进行扩展，注意返回的是Self类型，所以可以进行多个response。
 
 response 直接返回HTTPResponse，未序列化
 responseData 序列化为Data
 responseString 序列化为Json
 responseString 序列化为字符串
 responsePropertyList 序列化为Any
 
 
 1、AFError。枚举。通过枚举将网络请求的错误分为5大类。可以查看源码，看作者的逆天设计。
    case invalidURL(url: URLConvertible) // url验证失败。关联已URLConvertible枚举。
    case parameterEncodingFailed(reason: ParameterEncodingFailureReason) // 参数编码失败。同样关联一枚举。
    case multipartEncodingFailed(reason: MultipartEncodingFailureReason) // 上传时候出现的错误。如上。
    case responseValidationFailed(reason: ResponseValidationFailureReason) // reponse验证失败。如上。
    case responseSerializationFailed(reason: ResponseSerializationFailureReason) // reponse序列化失败。
 
 Swift中Error是一个协议。 LocalizedError也是一个协议，用来将错误表象化。 只要我们遵循了该协议，就能通过throw 来进行错误抛出，而且通过 do-catch 进行错误捕捉。
 
 2、Notification。 注意，Notifaction.Name的类型，以及使用。特别是对其扩展。
 
 3、ParamesEncoding一个协议，暴露一个方法，encode方法，其功能就是讲参数编码到url中，返回URLRequest。
    Alamofire提供了已个URLEncoding结构体，遵循了该协议，来实现编码功能。可参看ParameterEncoding.swift查看源码。
    URLEncoding，是将参数编码到url中。
        核心方法。queryComponents（将参数压扁，是一个递归函数处理了value为数组或者字典的时候）、query（将参数拼接成key=value的形式）、excape、
    JsonEncoding，是将参数编码成jsonData，放在httpBody中。
        通过JSONSerialization类将参数转换成data，然后放在urlRequest.httpBody当中。
    PropertyListEncoding，是将参数编码成PropertyListSerialization，放在httpBody中。
 
 4、Result的封装。
 
 5、TaskDelegate.swift。用来处理和请求相关的代理方法。也是核心类。
    URLSessionTaskDelegate、URLSessionDataDelegate、URLSessionDDownloadDelegate等，请求、下载、上传
    的一些代理方法。
 
    一些代理方法解释：
TaskDelegeta: 基类，用于处理基本回到方法。
    willPerformHTTPRedirection // 用于重定向的。一般我们发送请求，可能服务器并没有返回成功报文，而是返回的重
    定向报文，返回reponseCode 一般是3xx表示重定向。
 
    didReceiveChallenge // 接收到挑战。
    这里有一个很重要的问题： 如果使用的是HTTPS是不会触发该方法的，原因就是NSURLSession内部有一个根证书，
        内部会跟服务器的证书进行验证，如果服务器的证书是证书机构颁发的话，就可以顺利通过验证，否则会报错。
 
    另一个很重要的问题是，上边的方法在何种情况下触发，按照apple的说法URL Session Programming Guide,当服务器响应头中包含WWW-Authenticate或者使用 proxy authentication TLS trust validation时，上边的方法就会被触发，其他情况下都不会触发。
 
    Alamofire采用的是双向验证。可参考源码，如果let serverTrust = challenge.protectionSpace.serverTrust
    那么客户端会利用ServerTrustPolicy来进行客户端验证。
 
    needNewBodyStream // 当给task的Request提供一个body stream时才会调用，我们不需要关心这个方法，即使我们通过fileURL或者NSData上传数据时，该函数也不会被调用，使用场景很少。
 
    didCompleteWithError // 当请求出现错误的时候调用。注意： 里面对DownloadTaskDelegate做了特殊处理。
        downloadDelegate.resumeData = resumeData
 
 DataTaskDelegate: 继承TaskDelegate，并实现URLSessionDataDelegate协议。
    didReceive： response  complementHandle 接收到服务器响应的时候调用，我们可以如下
    complementHandel(value: URLSession.ResponseDisposition)，来进行一些操作，确定是否获取服务器数据，
    ResponseDisposition，其实是个枚举： cancel-取消，allow-允许， becomeDownload，当我们社会组为
    becomeDownload的时候，会调用下面的方法。
 
    didBecome: 调用时机，参考如上。 也就是，允许将我们的请求，变成一个下载。
 
    didReceive data: 当接收到返回数据d时候调用。
    里面牵扯到一个Progress类的使用。
 
    willCacheResponse: 缓存策略。 通过NSURLCache进行缓存。可以通过sessionConfit进行配置，默认cacheProtocol。
    默认缓存策略，需要配合header中cache-control字段使用。 当需要缓存会进行入该代理方法。
 
DownloadTaskDelegate： 继承TaskDelegate，并实现URLSessionDownloadDelegate协议。
    didFinishDownloadingTo： 当现在完成后调用。Alamofire的操作就是将下载完成后的内容，移到自己的下载目录。
 
    didWriteData： 当下载一点内容的时候，就会调用该方法。
 
    didResumeAtOffset： 当下载进行了暂停，如果我们进行恢复，会进入该代理方法中。
 
UploadTaskDelegate： 继承TaskDelegate。
    didSendBodyData： 上传时会进行回调。 该方法里面主要是做了进度处理。
 
 
 6、ServerTrustPolicy用于验证安全策略的。一般用于https。
 
 7、Response。
    Alamofire将Request分为，DataRequest、DownloadRequest、UploadRequest和StreamRequest几种。 而且
    对DataRequest做了扩展，而且能够进行响应式编程，因为每个方法返回的Self类型。
 
    其中有两个重要的结构体，DefaultDateResponse / DataResponse 。这个两个结构体，表示一个未序列化和一个序列化的
        响应数据。 因为是用来保存数据的，所以设计成Struct，因为结构体是值类型，保存数据更加安全。
 
    DataResponse比DefaultResponse多了Result属性，用于保存，序列化后的数据。
 
 
 8、ResponseSerailization是将返回Data数据进行序列化的。可以是Json、String等格式数据。
 
 9、MultipartFormData 多媒体表。试想如果我们想将多个文件上传给服务器，那么服务器应该如何识别这些文件
    呢，这就是MultipartFormdata的作用。将数据进行表单样式的提交。当content-type是
    Content-Type: multipart/form-data; 来表明客户端发送的数据是表单形式。
 
 
 10、TimeLine用来记录时间的。
 
 alamofire。链式编程之所以能够实现，其核心原理是通过SessionManager创建URLSession，同时设置delegate为TaskDelegate。而taskDelegate用来处理回调，
 并且有OperationQueue队列，queue.isSuspend = true （很重要）。其后面DateRequest.response 会将其操作放在delegate.queue.addOperation中，当delegate
 的回调结束调用queue.isSuspend = false，调用response方法。从而实现整个下载过程。
 
 */



class SSAlamofireVC: UITableViewController {


    
    lazy var datas = ["request","链式请求", "download","upload","SSNetwork","--"]
    
   
 
    // MARK:---- 注释标签
    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableView.tableFooterView = UIView()
        
        SessionManager.default.request("").responseString { (dataResponse: DataResponse<String>) in
            let result = dataResponse.result

            switch result {
            case let .success(jsonString):
                print(jsonString)
            case let .failure(error):
                print(error)
            }
        }
        
        
       
    }

    // TODO: 点半
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    // FIXME: 需要修改
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "cellId"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
        cell?.textLabel?.text = datas[indexPath.row]
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            requestFunc()
        }else if indexPath.row == 1 {
            requestChainFunc()
        }else if indexPath.row == 2 {
            downloadFunc()
        }else if indexPath.row == 3 {
            uploadFunc()
        }else if indexPath.row == 4 {
            customNetworkTool()
        }else {
            
            
            let dateRequest = request("https://httpbin.org/get").validate(statusCode: 200 ..< 300)
            
            print(dateRequest.delegate.data)

            dateRequest.responseData { (response: DataResponse<Data>) in
                print(dateRequest.delegate.data)

                print(response.result)

            }
            
           
            mineValidate(accepte: 12 ..< 14)
           
        }
    }
   
    @discardableResult // 可以忽略结果。
    func mineValidate<S: Sequence>(accepte: S) -> String where S.Iterator.Element == Int{
        
        return ""
    }
 
}


extension SSAlamofireVC {
    

    
    func requestFunc() {
        let urlString = "https://github.com/dreamCC/VetVersion/blob/master/locationInfo.json"
        let dataRequest: DataRequest = request(urlString)
        dataRequest.responseJSON { (response) in
             guard let jsonValue = response.value else { return }
             let dic = jsonValue as! [String:Any]
             print(dic)
        }
       
    }
    
    func requestChainFunc() {
        let urlString = "https://httpbin.org/get"
        request(urlString)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON { (response) in
            
            
            self.ss_print(response.value)
            
            }.responseString { (response) in
                self.ss_print(response.value)
        }
        
    }

    func downloadFunc() {
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        let distination: DownloadRequest.DownloadFileDestination = { (tempURL, resposne) ->  (URL, DownloadRequest.DownloadOptions)in

            var path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

            path.appendPathComponent("locationInfo.json")
            return (path, [.createIntermediateDirectories, .removePreviousFile])
        }

        let distination1 = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory, in: .userDomainMask)

        let urlString = "https://github.com/dreamCC/VetVersion/blob/master/locationInfo.json"
        Alamofire.download(urlString, to: distination1).responseJSON { (response) in
            guard let jsonValue = response.value else { return }
            let dic = jsonValue as! [String:Any]
            print(dic)

        }
//
//        var path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//
//        path.appendPathComponent("locationInfo.json")
//        let fileHandel = try? FileHandle(forReadingFrom: path)
//        let data = try? fileHandel?.readDataToEndOfFile()
//        print(data?.count)
//
//        guard let json = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) else {
//            return
//        }
//        print(json as! [String:Any])
        
        
    }
    
    
    func uploadFunc()  {
        
        
        SessionManager.default.upload(multipartFormData: { (formData) in
            
        }, to: "") { (result) in
            switch result {
            case .success(request: let upload, streamingFromDisk: _, streamFileURL: _):
                upload.responseJSON(completionHandler: { (response) in
                    print(response.value ?? "没有值")
                })
            case .failure(let  error):
                print(error)
            }
        }
    }
    
    private func ss_print(_ item: Any?...) {
        for value in item {
            print(value ?? "unKown")
        }
    }
}

extension SSAlamofireVC: URLSessionDataDelegate{
    func customNetworkTool() {
        let network = SSNetwork.default
        network.requset(url: "", parames: [:], success: { (response) in
            
        }) { (error) in
            
        }
        
    
       
    }
    
    func requestRout() {
        
        let route = RequstRoute.login(name: "zhangsan", pwd: "124567")
        request(route).responseJSON(queue: DispatchQueue.main, options: JSONSerialization.ReadingOptions.mutableLeaves) { (response) in
            
            

        }
    }
    
    
}


