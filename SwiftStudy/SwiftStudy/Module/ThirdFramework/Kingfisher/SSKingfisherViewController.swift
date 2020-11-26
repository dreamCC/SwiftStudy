//
//  SSKingfisherViewController.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/10/28.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit
import Kingfisher

/*
 Kingfisher对于kf的设计，简直完美。 相对于SnapKit（SnapKit中对于view.snp其实snp是extentsion UIView的属性），
 而Kingfisher则完美的使用泛型、泛型协议和协议扩展以及泛型类型和泛型类型约束来实现。我们通常也可以借助该写法：
 其实我们理解其写法就发现：其内部就是SnapKit实现的一种变异。
 其实SnapKit通过extentsion实现的好处是所有的UIview都有snp属性，而Kingfisher之所以这样设计并不是所有的UIView都能通过
 kf进行设置。
 
 其实这种设计可以运用在项目中，比如为了防止分类中方法重叠，我们可以通过该方法进行赋值。
 其实React也是这样实现的。
 */

class Zfisher<Base> {
    let base: Base
    init(_ base: Base) {
        self.base = base
    }
}

// Zfisher进行扩展
extension Zfisher where Base: UIImage {
    
    var imageScal: CGFloat {
        get {
            return base.scale
        }
    }
}


extension Zfisher where Base: UIView {
    
    var bgColor: UIColor? {
        get {
            return base.backgroundColor
        }
    }
}

// 保证能够获取Zfisher。
protocol ZfisherCompatible {
   
    associatedtype CompatibleType
    var zf: Zfisher<CompatibleType> {get}
}

extension ZfisherCompatible {
    
    var zf: Zfisher<Self> {
        return Zfisher(self)
    }
}
extension UIView: ZfisherCompatible {}


///-----------------------------------
// 所以我们得出结论： 在protocol中尽量通过associatedtype替代Self。而在extension protocol中尽量使用Self。
struct SwiftStudyDemo<Base> {
    
    var base: Base
    init(_ base: Base) {
        self.base = base
    }
}

protocol SwiftStudyCompatible {
    
    associatedtype CompatibleType
    var vet: SwiftStudyDemo<CompatibleType> {get}
}

extension SwiftStudyCompatible {
    
    var vet: SwiftStudyDemo<Self> {
        return SwiftStudyDemo(self)
    }
}


extension UIView: SwiftStudyCompatible {}
extension SwiftStudyDemo where Base: UIView {
   
    
}


// 这种写法有一定好处，当然也有一定风险。
protocol SSModify {
    
    var name: String {get}
    var fullName: String {get}
    
    
    func modify(_ name: String) -> String
}

extension SSModify {
   
    var fullName: String {
        get {
            return name + ":SSModify"
        }
    }
    
    func modify(_ name: String) -> String {
        print("protocol call modify")
        return modify(name)
    }
    
    // 这种写法。
    func goto() -> SSModify {
        print(Self.self)
        return TestSSModify(name: "TestSSModify")
    }
    
   
}

class TestSSModify: SSModify {
    var name: String
    
    
    func modify(_ name: String) -> String {
        print("protocol call modify")
        return "hello"
    }
    
    init(name: String) {
        self.name = name
    }
    
}

class TestSSModify1: SSModify {
    var name: String {
        return "TestSSModify1"
    }
    
}




class SSKingfisherViewController: QMUICommonViewController {

    typealias SuccessCallBack = (String, String)->Void
    var sucCallBack: SuccessCallBack?
    
    @IBOutlet weak var imageV: AnimatedImageView!
    
    private(set) var name: String = "helo" {
        willSet {
            print("name 开始设置", newValue)
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let dm = TestSSModify(name: "enha")
        print( dm.goto())
        print( TestSSModify1().goto())

      
        //kingfisherImageSources()
        //kingfisherPlaceHolder()
        //kingfisherAllParameters()
        
        //print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last ?? "为空-", NSHomeDirectory())

       
       
        let catPath = Bundle.main.path(forResource: "cat.gif", ofType: nil)
        let image: Image = UIImage(contentsOfFile: catPath!)!
        imageV.image = image

    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // 两种方法，使代码整合。 方法内部多次调用的话，可以采用该方式。
        let startAppend: (String)->(String) = {(name)-> String in
           return self.name.appending(name)
        }
        
        print(startAppend("age"))
        
        func append(name: String) -> String {
            return self.name.appending(name)
        }
        
        print(append(name: "appendMethod"))
    }

    private func kingfisherUrl() {
        
        guard let url = URL(string: "http://mvimg2.meitudata.com/55fe3d94efbc12843.jpg") else {
                  print("url 初始化失败")
                  return
        }
              
        imageV.kf.setImage(with: url)
    }

    private func kingfisherImageSources() {
        
        guard let url = URL(string: "http://mvimg2.meitudata.com/55fe3d94efbc12843.jpg") else {
                  print("url 初始化失败")
                  return
        }

        let imageSources = ImageResource(downloadURL: url, cacheKey: "cache_key")
        imageV.kf.setImage(with: imageSources)
    
    }
    
    private func kingfisherPlaceHolder() {
        
        guard let url = URL(string: "https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3245371152,3456791010&fm=26&gp=0.jpg") else {
                  print("url 初始化失败")
                  return
        }
        
        let placeHolder = UIImage(named: "icon_moreOperation_shareMoment")
    
        imageV.kf.setImage(with: url, placeholder: placeHolder)
        
    }
    
    private func kingfisherAllParameters() {
        
        guard let url = URL(string: "https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3245371152,3456791010&fm=26&gp=0.jpg") else {
                  print("url 初始化失败")
                  return
        }
        
       let placeHolder = UIImage(named: "icon_moreOperation_shareMoment")
        imageV.kf.indicatorType = .activity
        imageV.kf.setImage(with: url, placeholder: placeHolder,
                           progressBlock: { (recive: Int64, totoal: Int64) in
                            
                            print(recive/totoal);
        })

        
        
    }
    
    

    
    deinit {
        
        // 清空缓存
        ImageCache.default.clearDiskCache()
        ImageCache.default.clearMemoryCache()
    }

}

extension Kingfisher where Base : UIImageView {
    
    func setImage(with imageUrl: String) {
        
        guard let url = URL(string: imageUrl) else {
            return
        }
        
        setImage(with: url)
        
    }
    
}


