//
//  SSKeyWordVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2019/12/25.
//  Copyright © 2019 Zhu ChaoJun. All rights reserved.
//

import UIKit
import HandyJSON
import Alamofire
/*
 
 结构体不能继承、类能继承。
 
 @discardableResult 表示，可以忽略返回值。默认有返回值，如果不接受会报错。
 
 mutating。一般用于enum、struct和protocol（修饰相应的方法，那么遵循该协议的结构体和枚举就能修改其值）中。默认struct中的属性，是immutable的，即初始化后就不能改变的，如果我们想要修改，就需要使用 mutating对方法进行修饰。
 
 static 和 class。
    static 可以修饰类或者是结构体。 而且可以修饰存储属性（保存在内存常量区）、计算属性、方法。且不能重写。
    class只能修饰类方法，或者类的计算属性（因为类的存储属性，声明后是保存在内存常量区的，而且是不可变的，而class明显不具备这个能力）。
    而且当class修饰类方法时候，子类是可以重写的。
    在Protocol中，最好使用static，因为Protocol一般struct、class、enum都能遵循，但是如果使用class修饰，那么只能class才能调用。
 
 as as？ as！三者间的关系。
    as表示向上转换，由派生类转换为基类。
    as? 和 as！向下转换，比如UITableViewDelegate里面的代理方法， 获取cell是常用遇到，将UITableViewCell转换
        成UITableViewCell的子类Cell。 不同点：是否生成可选类型。
 
 Any和oc中id的区别。Any表示任意一指定类型，所以Option类型和nil并不属于Any。 但是oc中，id可以修饰任意值。
 
 private、filePrivate、internal、public、open。 三个权限依次增加。  private私有权限，只有当前文件才能访问。
     internal默认的访问权限。internal修饰的属性和方法，整个命名空间内都可以访问。
     public修饰，可以被任意访问，但是只能在module内进行重写和继承。
     open修饰，可以被任意访问，而且可以重写和继承。 如果对非open类进行继承和重写就会报错。
    而且这些关键字修饰属性的时候，可以配合set、get使用如private(set) var name: String那么就是set是私有
 的，而get是internal访问权限的。
 
 is做类型判断的，判断一个对象是否是一个类或者其子类的。 as as? as!是做类型转换的。
 
 defer { //代码，会在return之前执行 } 。因为defer 延时调用的特性，所以一般用于资源的释放。 这在一个方法有多个return的时候特别
    有用。
 
 关于try try？ try！。 try在 do{} catch{} 中使用， try? 返回可选类型。 try!系统会帮着解包，如果解包失败会报错。
 
 convenience遍历构造方法 修饰init方法。 但是前提不能和父类的构造方法一样。 和确定构造函数的区别，确认构造函数自定义
    后，就不会再继承父类构造方法。 convenience init(name: xxxx) 相当于增加构造方法，不会影响继承父类的构造方法。
    遍历构造方法不能修饰继承父类的构造方法。
 
 inout 表示是将值传递的类型，变成引用传递类型。一般用于方法参数前面。
 
 Self和self。首先说self，其常见用法self.（这种很常见，比如我们在对象方法中表示对象本身，在类中
    表示类本身）。还有一种就是.self(如果用在类型后面表示类型本身，用在实例后面表示实例本身。)，
    比如SSKeyWordVC.self表示类型本身，即SSKeyWordVC.Type其实就是class，因为swift中
    public typealise AnyClass = AnyObject.Type。
    Self一般用在协议中。表示遵循该协议的类型。
 
 where用来进行条件限定的，使用场景如下。
    1、协议，protocol ShakeAble where Self: UIView {} 。对协议进行限定。
    2、for item in arys where item > xx 遍历时候限定。
    3、switch中的case语句。 比如，swift xx { case let a where a.count == 3 }
    4、if 或者 guard中，但是swift 4.0之后就使用, 来代替
 
 @objc。因为swift是静态语言，每个方法在编译的就需要确定有没有被调用，如果没有被调用，苹果就会对包进行优化删除。
    用来减少包体积。但是oc是动态语言，即编译的时候是不知道方法是否被调用的，只有运行的时候才能确定。这样引入了
    一个问题，也就是苹果在对swift类进行优化的时候，那么不知道该类有没有被oc调用，所以就需要手动的增加@objc来
    进行标识。
 
 dynamic关键字可以修饰属性和方法。用来标记属性或者方法具有动态特性。比如使用kvo其属性需要使用dynamic，swift中的方法，如果oc中想要使用method swizzing那么也需要dynamic关键字修饰。
 
 
 extension扩展。和oc中的分类有点像，但是又不一样。
    1、首先oc中有Category和extention两种，Category是基于runtime实现的，本质是objc_category结构体，extention其实就是在原类的基础上增加方法属性的。但是Category是基于runtime在dylb链接的时候加载到objc_class的ivars和methodList中的，这也是其不能添加属性的原因。
    2、swift中其实没有Category概念，但是引入了extension扩展。
 
 typedefine、typeof和define的区别。
 typedefine将一种类型转换成另一种类型。
 typeof(xxx)获取xxx类型。比如__weak typeof(self)weakSelf = self; 等价于 __weak UIViewController *weakSelf = self;
 define定义宏。
 */

class SSKeyWordVC: UIViewController {

    private var name: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        view.backgroundColor = UIColor.white
        navigationItem.title = "关键字"
        
    
    }
    

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        deferForExample()
    }
    
    // ----- defer
    func deferFunc() {
        print("func 开始执行")
        
        /* defer里面的代码块会在return之前执行。而且是一定会执行 */
        defer {
            print("defer 执行")
        }
        
        let range: CountableRange = 1 ..< 10
        
        for index in range {
            print(index)
        }
    }
    
    func deferForExample() {
        
        // FileHandle 和 FileManager的使用。
        // FileHandle有一个移动的指针，指向文件的偏移。
        guard let filePath = Bundle.main.path(forResource: "summary", ofType: nil) else {
            return
        }
        
        let fileMng = FileManager.default
        print(fileMng.fileExists(atPath: filePath))
        let data = fileMng.contents(atPath: filePath)
        print(data?.count ?? "")
        let contentString = String(data: data!, encoding: .utf8)
        print(contentString!)
        
        guard let fileWritingHandle = FileHandle(forWritingAtPath: filePath) else {
            return
        }
        
        // 有多个return。 defer关键字的作用显得格外重要。
        defer {
            fileWritingHandle.closeFile()
            
        }
        fileWritingHandle.seek(toFileOffset: 10)
        let writeStr = "FileHandle write"
        guard let wirteData = writeStr.data(using: .utf8) else {
            return
        }
        fileWritingHandle.write(wirteData)
        
        
        //--- reading
        let fileUrl = URL(fileURLWithPath: filePath)
        guard let fileReadingHandle = try? FileHandle(forReadingFrom: fileUrl) else {
            return
        }
        
        defer {
            fileReadingHandle.closeFile()
        }
        let readData = fileReadingHandle.readData(ofLength: 1024)
        print(String(data: readData, encoding: .utf8) ?? "read is nil")
        
    }
    
    
}




