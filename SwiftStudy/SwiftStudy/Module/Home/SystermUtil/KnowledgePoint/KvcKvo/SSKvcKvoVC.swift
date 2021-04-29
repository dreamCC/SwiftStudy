//
//  SSKVCVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/4/28.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit


class SSKvcKvoVC: SSBaseViewController {

    
    
    @objc var name: String!
    var kvoClass = KvoClass()
    var kvcClass = KvcClass()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
        

    @IBAction func kvcBtnClick(_ sender: UIButton) {
        
        kvcClass.setValue("yes", forKey: "name")
        print(kvcClass.name)
    
        
        
    }
    
    @IBAction func kvoBtnClick(_ sender: UIButton) {
        
    
        
        print("kvo 之前", object_getClass(kvoClass)!)
        kvoClass.addObserver(self, forKeyPath: #keyPath(name), options: [.new], context: nil)
        print("kvo 之后", object_getClass(kvoClass)!)
        
        kvoClass.name = "newVlaue"
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        print("observeValue：==", keyPath , change)
        
    }
    
}


/*
 
 首先我们知道能使用kvc的根本原因是，必须要遵循NSKeyValueCoding协议。 所以swift如果想使用kvc一般继承NSObjcet
 就可以。 但是使用的时候还会报错，因为swift属性，想要被oc使用，就必须要加上@objc方法。
 
 这里牵扯到kvc的原理问题：
 1、查找模型中有没有setName:方法，如果有就直接赋值。
 2、如果没有，就会查看accessInstanceVariablesDirectly是否返回true，如果返回true，继续模型中的属性列表中是否有_key, key等，如果有就直接赋值。
 3、如果没有，就会查找模型中有没有isName属性，有就直接赋值。
 4、如果都没有，就会直接报错。 setValue： forUndefineKey:
 
 kvc中几个重要方法的重写
 */
class KvcClass: NSObject {
    
    @objc var name: String  = ""
    
    /* 属性重写，当没有该属性的时候，会调用该方法 */
    override class var accessInstanceVariablesDirectly: Bool {
        get {
            print("accessInstanceVariablesDirectly")
            return true
        }
    }
    
    /* 当setValue forKey中，如果key为空会进入该方法中 */
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        print("setValue(, forUndefinedKey)", key)
    }
    
    
    
    /* kvc获取属性，如果key没有会进入该方法 */
    override func value(forUndefinedKey key: String) -> Any? {
        print("value(forUndefinedKey key: String)", key)
        return nil
    }
}

/*
   
   kvo监听
   kvo-key value observing。 和NotifacationCenter一样，属于苹果的观察者模式。
   不同点是，kvo是一对一，通知是一对多。
 
   使用需要注意，addObserVer方法进行监听，由于kvo并不会对observer进行强引用，所以需要注意observer的生命周期
   注意合适的时间进行remover
 
   其内部是通过isa-swizzling实现。当运行的时候会创建一个中间类，而这个中间类是原类的子类，并且会动态的修改当前
   对象isa指针，指向这个中间类，同时将+class方法重写，返回原类的class。中间类一般以NSKVONotifyfying_xxx
   命名。
 
   kvo的核心方法是set方法，一般中间类NSKVONotifying_xxx会重写父类的set方法，在该方法内部是实现通知机制。在setXX方法中，会调用willChangeValue和didChangeValue，同时还会调用obserValue方法。

 */

class KvoClass: NSObject {
    
    
    @objc dynamic var name: String = ""

    
    
    override func willChangeValue(forKey key: String) {
        print("willChangeValue", key)
        super.willChangeValue(forKey: key)
    }
    
    
    // 是否自动触发kvo。默认是true，如果关闭调，则需要手动
    // self.willChangeValue，self.didChangeValue来触发。
    override class func automaticallyNotifiesObservers(forKey key: String) -> Bool {
        return true
    }

    // 属性关联值设置。
    override class func keyPathsForValuesAffectingValue(forKey key: String) -> Set<String> {
        if key == "" {
            return []
        }
        return super.keyPathsForValuesAffectingValue(forKey: key)
    }
}

