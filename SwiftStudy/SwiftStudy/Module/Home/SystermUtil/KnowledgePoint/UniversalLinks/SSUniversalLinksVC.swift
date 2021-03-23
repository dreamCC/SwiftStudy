//
//  SSUniversalLinksVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/1/9.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit

/*
 首选我们需要知道，urlSchema的作用。
 我们通过配置urlSchema后:
 1、通过UIApplication.share.open来打开配置过该schema的app。
 2、在safari上面输入 xx:// 后会有提示，我们是否打开schema是xx的app。
 
 UniversalLink通用链接。
 通用链其实就是一条普通的 http 链接。比如：https://www.hangge.com/app
 如果我们的 App 支持通用链接，且设备中安装了该 App。那么当用户点击链接，就会直接进入到我们的 App 中了。
 如果设备中没有支持这个链接的 App，那么点击链接后还是继续进到链接对应的 html 页面中。完全不需要我们人为判断是去打开 App，还是打开 Web 页面。
 同时通过通用链接进入到 App 这个过程是不会弹出提示框的，整个流程十分顺畅。（如果手机安装了“知乎”，我们随便在浏览器中搜索一个知乎页面点击就可以看到效果。）
 
 通用链接的好处：
 唯一性：不像自定义的 scheme，因为它使用标准的 http/https 链接到你的 web 站点，所以它不会被其它的 app 所声明。另外，Custom URL scheme 因为是自定义的协议，所以在没有安装 app 的情况下是无法直接打开的，而 universal links 本身是一个 HTTP/HTTPS 链接，所以有更好的兼容性。
 安全：当用户的手机上安装了你的 app，那么 iOS 将去你的网站上去下载你上传上去的说明文件(这个说明文件声明了你的 app 可以打开哪些类型的 http 链接)。因为只有你自己才能上传文件到你网站的根目录，所以你的网站和你的 app 之间的关联是安全的。
 可变：当用户手机上没有安装你的 app 的时候，Universal Links 也能够工作。如果你愿意，在没有安装你的 app 的时候，用户点击链接，会在 safari 中展示你网站的内容。
 简单：一个 URL 链接，可以同时作用于网站和 app。
 私有：其它 app 可以在不需要知道你的 app 是否安装了的情况下和你的 app 相互通信
 
 
 */
class SSUniversalLinksVC: SSBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


        titleName = "UniversalLink"
        
        
    }
    
    @IBAction func openUrl(_ sender: UIButton) {
        
        let url = URL(string: "https://www.baidu.com")!
        UIApplication.shared.open(url, options: [:]) { (isSuccess) in
            print(isSuccess)
        }
     
    }
    
    /*
     关于openUrl。UIApplication.OpenExternalURLOptionsKey.universalLinksOnly， 对应的value有两个值
     true和false。 如果UIApplication.OpenExternalURLOptionsKey.universalLinksOnly:true。 那么表示，
     如果没有安装相应的app， 并不会使用safari来打开。
     */
    @IBAction func openUrlUniversalLinks(_ sender: UIButton) {
        let url = URL(string: "https://www.baidu.com")!
        UIApplication.shared.open(url, options: [UIApplication.OpenExternalURLOptionsKey.universalLinksOnly:true]) { (isSuccess) in
            print(isSuccess)
        }
    }
}
