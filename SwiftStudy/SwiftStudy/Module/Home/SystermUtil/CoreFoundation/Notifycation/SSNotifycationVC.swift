//
//  SSNotifycationVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2019/12/25.
//  Copyright © 2019 Zhu ChaoJun. All rights reserved.
//

import UIKit

/*
 
 在oc中。NSNotifactionCenter通知中心是一个类。NSNotifacation传送的通知对象，通过该类可以获取通知中传播的数据。
 NotifacationName也是一个字符串。
 
 在swift中。做了一些改变。NotifactionCenter通知中心还是一个类。
    Notifaction成了结构体。 其Name就是NSNotifycation.Name。 可参考代码：
    public typealias Name = NSNotification.Name。如下：
    这样做的好处是，使其可读性更强。
 
 extension NSNotification {
 
 
        public struct Name : RawRepresentable, Equatable, Hashable, Comparable {
 
        public init(_ rawValue: String)
 
        public init(rawValue: String)
    }
 }
 
 可参考Alamofire中，Notifation.swift中对于Notifation.Name的扩展。
 
 */

// 一般开发中，通过扩展来进行实现。
extension Notification.Name {
    
    // 登录成功
    static let loginSuccess = NSNotification.Name("working")
    
}

// 如果想详细区分。Alamofire：
extension Notification.Name {
    
    struct Login {
        static let success = Notification.Name("sucess")
        static let error = Notification.Name("error")
    }
    
    struct Refresh {
        static let refreshHome = Notification.Name("refreshHome")
        static let refreshBody = Notification.Name("refreshBody")
    }
}


class SSNotifycationVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        // 甚至可以通过下面这种写法，来详细区分。
        NotificationCenter.default.post(name: Notification.Name.loginSuccess, object: nil)
        NotificationCenter.default.post(name: Notification.Name.Login.success, object: nil)
        NotificationCenter.default.post(name: Notification.Name.Login.error, object: nil)
        
        let a = Notification.Name(rawValue: "en")
        print(a, a.self)
        
        
    }

  
}


