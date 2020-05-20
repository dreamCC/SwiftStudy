//
//  SSRuntimeVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2019/12/28.
//  Copyright © 2019 Zhu ChaoJun. All rights reserved.
//

import UIKit

/*
 Runtime知识点：
 将源代码变成可执行程序，一般需要经过编译、链接、运行三个过程。不同的语言可能有些差异。一般静态语言在编译的时候就已经知道了变量类型、调用的函数以及实现等，比如c、swift等。但是oc是动态语言，在编译阶段是不知道变量的具体类型以及调用的函数，只有在运行时才会知道，这也使得oc非常灵活，我们可以在运行的时候来动态修改一些方法实现，这也就给热更新提供了可能，而Runtime其实就是一个库，这个库可以让我们在程序运行的时候动态的创建、检测、修改对象等。
    
 runtime消息机制的原理：
 1、编译阶段：[reciver selector]; 方法会被编译器转换为：objc_msgSend(recever, selector)不带参数或者是带参数objc_msgSend(reciver, selector, org1, ....)带参数。
 2、运行阶段：消息接受者recevier寻找对于的selector：
    a、通过recevier的isa指针找到recevier的Class(类)；
    b、在Class的cache（方法缓存）中找selector对于的IMP（方法实现）；
    c、如果cache（方法缓存）中没有找到，那么就会在methodList（方法列表）中找对于的selector，如果找到那么同时会将该方法存放在cache中。
    d、如果没有找到那么就会通过Class中的isa指针去寻找superclass类，同时指向b、c两步。
    f、如果都没有找到，那么就会报unselector错误。
 
 ---------------------------------------------------------------

 runtime中重要知识点：
 stuct objc_object{
    Class _Nonnull isa;
 };
 typedef struct objc_object *id;
 
 struct objc_class {
 
    Class _NonNull isa;         // 指向元类meta class，即类对象所属的类。类方法的调用就需要该指针
    Class _NonNull super_class; // 指向父类
    const char * _NonNull name; // 类名
    long  version;              // 类的版本信息，默认是0
    long  info;                 // 类的信息，供运行期间使用的一些表示
    long  instance_size;        // 该类实例大小
    struct objc_ivar_list   * _Nullable ivars;        // 类的实例变量列表
    struct objc_method_list * _Nullable methodLists;  // 方法列表
    struct objc_cache * _NonNull cache;               // 方法缓存
    struct objc_protocol_list * _Nullable protocols;  // 遵循的协议
 }
 typedef struct objc_class *Class;
 
 // 成员变量列表
 struct objc_ivar_list {
    int ivar_count;
    int space;
    struct objc_ivar ivar_list[1]; // 成员变量列表
 }
 
 // 成员变量
 struct objc_ivar {
    char * _Nullable ivar_name;
    char * _Nullable ivar_type;
    int ivar_offset;
    int space;
 }
 
 
 // 方法列表
 struct objc_method_list {
    struct objc_method_list * _Nullable obsolate;
    int method_count;
    int space;
    struct objc_method method_list[1]
 }
 
 // 方法
 struct objc_method {
    SEL _Nonnull method_name;  // 方法名
    char *_Nullable method_type; // 方法类型，用于存放方法参数和返回值。
    IMP  _Nonnull  method_imp; // 方法实现
 }
 
 // 协议
 struct objc_protocol_list {
    struct objc_protocol_list * _Nullable next;
    long count;
    __unsafe_unretain Protocol * _Nullable list[1];
 }
 
 // 缓存
 struct objc_cache {
    unsigned int mask;
    unsigned int occupied;
    Method _Nullable buckets[1];
 }
 
 typedef struct objc_selector *SEL;
 typedef void (*IMP)(void /* id, SEL, ... */ );
 typedef struct objc_method *Method;
 
 
 从上面可以看出，oc中任意对象的本质其实是结构体指针，指向objc_objcet结构体。而该结构体有Class类型的isa指针。也就是说，一个Object对象，唯一保存的就是其所属的Class的地址。当我们对一个对象进行方法调用的时候，比如[obj selector];，它会通过其isa指针，找到其objc_class,并在cache或者methodList中寻找其实现。
 
 上面是对象方法调用过程，其实类方法的调用就需要objc_class的isa指针。比如[NSString stringWithFormatxx
    方法，那么就会通过NSString类的isa指针，找到NSString类的元类，并且在其methodList方法中找stringWithFormate方法，如果只选该方法的实现。
 
 ---------------------------------------------------------------

 消息的动态解析：
 如果方法未找到，我们可以重定向方法。
 // 类方法未找到时调起，可以在此添加方法实现
 + (BOOL)resolveClassMethod:(SEL)sel;
 // 对象方法未找到时调起，可以在此添加方法实现
 + (BOOL)resolveInstanceMethod:(SEL)sel;
 比如：
 // 重写 resolveInstanceMethod: 添加对象方法实现
 + (BOOL)resolveInstanceMethod:(SEL)sel {
     if (sel == @selector(fun)) { // 如果是执行 fun 函数，就动态解析，指定新的 IMP
         class_addMethod([self class], sel, (IMP)funMethod, "v@:");
         return YES;
     }
     return [super resolveInstanceMethod:sel];
 }

 void funMethod(id obj, SEL _cmd) {
     NSLog(@"funMethod"); //新的 fun 函数
 }
 
 ---------------------------------------------------------------
 
 method swizzling动态交换方法。
 其实现原理：
 正常情况下，Class维护了一个methodList方法列表，里面对于的objc_method结构体是一一对应的，比如SEL A: IMP A, SEL B :IMP B，交换后SEL A: IMP B，SEL B:IMP B。
 oc中，一般在+load方法中进行交换。
 其中核心方法method_exchangeImpltation
 常见使用场景。
 1、全局统计页面，比如统计一个页面访问次数，可以改变viewWillAppear方法。extention UIViewController
 2、全局改变字体。extent UIFont， systermFontSize
 3、防止按钮多次点击。extent UIButton， sendAction: to： forEvent:
 4、UITalbeView和UICollection加载空白view。 extention UITableView 交换reloadData，比如UITalbe+dzEmptyview就是使用该方法。
 
 ---------------------------------------------------------------
 Category底层原理。
 Category在即新建子类、也不侵入一个类的源码的情况下，给原有类增加方法。日常开发中常常使用分类来给原类增加方法。
 Category和Extention(类扩展)的区别。Extention可以给类添加属性、方法，但是必须在@impletation中实现。
    Category不能添加属性。 extnetion之所以能添加，是因为在编译阶段和该类同时编译的，其实就是类的一部分。
    但是Category不一样，Category的特性是在运行阶段动态的为类添加新行为。Category是在运行期间决定的。
    而成员变量的内存分布其实是在编译阶段就已经确定好了的。
 
 typedef objc_category *Category;
 struct objc_category {
    char * _Nonnull category_name;
    char * _Nonnull class_name;
    struct objc_method_list * _Nullable instance_methods;
    struct objc_method_list * _Nullable class_methods;
    struct objc_protocol_list * _Nullable protocols;
 }
 
 从上面定义可以看出，Category可以添加对象方法、类方法和协议，但是不能添加属性。
 
 Category加载过程。我们知道Category是在运行时动态加载的。而Runtime（运行时）加载过程，离不开dylb的动态链接器。其中工作原理非常复杂，但是我们需要知道的是dylb在执行动态链接后，会执行_objc_init这也是runtime初始化的过程，该过程中，有一个重要的步骤就是attachCategories(cls, cats, true);，该方法就是用
     来存储分类方法、协议而的。
 需要注意：
 1、存储分类方法、属性、协议的时候并不会替换原有的类的方法、属性和协议。比如原类有methodA方法，而分类也有methodA方法，那么加载完分类后，类的方法类别中就有两个mehtodA方法。
 2、Category分类的属性、方法、协议会在加载的时候添加到原类的最前面，而原类的属性、方法、协议会放在后面，因为运行时查找方法是按属性查找的，所以有相同方法的时候Category方法会先搜索到然后执行，而原类的方法不会被执行。这也是Category中的方法会覆盖掉原类方法的根本原因。
 
 Category中的属性、方法、协议是在dylb动态链接的时候加载到原类上的，是在+load方法执行之前（运行时候执行）加载的。所以+load方法执行的时候，Category方法已经加载了。
 
 runtime可以给分类添加属性。
 
 ---------------------------------------------------------------
 获取类的全部属性和方法，需要借助runtime库。苹果暴露的一些类，只给我们一些常用属性，有些属性是隐藏的，如果想要获取就需要借助runtime只是。
 class_copyIvarList(class, &count)       获取成员变量列表。
 class_copyPropertyList(class, &count)   属性列表
 class_copyMethodList(class, &count)     方法列表
 class_copyProtocolList(class, &count)   协议列表
 */


/*
 swift是静态语言。其优点是编译时候确定调用的函数和类，没有调用的直接删除调。会优化app包，同时提高性能。缺点就是，没有了类似oc的动态特性。

 swift中有两种类：
 1、继承了OC类，比如UIView、UIViewController等，那么其重写的oc方法如viewDidload方法，还是通过runtime机制继续调用的，即objc_msgSend。但是如果新增方法，比如增加foo方法，那么该方法的调用就和runtime没什么关系。
 2、从系统swift基类，SwiftObjcet派生出来的类，如果我们Swift类什么都不写，那么默认会继承SwifObjct类，该类影藏类，不会再代码中体现出来。
 
 Swift类对象的内存分布和oc类对象的内存分布很像。二者对象都有isa指针只想类的描述，而swift类的描述继承了oc类的描述，但并没有完全使用里面定义的属性。
 比如我们定义：
 //假设定义了一个CA类。
 class CA {
    init(_ a:Int){}
 }
 
 //编译生成的对象内存分配创建和初始化函数代码
 CA * XXX.CA.__allocating_init(swift_class  classCA,  int a)
 {
     CA *obj = swift_allocObject(classCA);  //分配内存。
     obj->init(a);  //调用初始化函数。
 }

 //编译时还会生成对象的析构和内存销毁函数代码
 XXX.CA.__deallocating_deinit(CA *obj)
 {
    obj->deinit()  //调用析构函数
    swift_deallocClassInstance(obj);  //销毁对象分配的内存。
 }
 其中swift_class就是objc_class结构体派生出来的。
 
 
 //Swift类描述
 struct swift_class {
     ...   //其他的属性，因为这里不关心就不列出了。
     struct method_t  methods[1];
     ...   //其他的属性，因为这里不关心就不列出了。
     //虚函数表刚好在结构体的第0x50的偏移位置。
     IMP vtable[1];
 };
 swift中，如果是oc特性还是和oc中runtime是一样的，但是如果是swift的函数则保存在vtable虚函数表中。
 
 swift中变量的访问。swift的变量和oc中的ivar也是不一样的。oc中，在objc_class中会提供一个objc_ivar_list来保存所有的成员变量。而swift中的成员变量的访问要简单的多，swift会将类的成员变量，之间生产set/get方法，并将方法保存在虚表函数中，其调用和赋值和swift函数的调用是一样的。这也解释了为什么swift没法使用oc中kvc（其实利用ocruntime本质，在ivars中查询并赋值的）。
 
 swift类的extention定义的方法，是以硬编码的形式存在的。这也是swift中extention无法进行runtime的method swizzling的原因，我们想要使用runtime就必须借助@objc关键字修饰。

*/
class SSRuntimeVC: SSBaseViewController {

    let swiftClass = SwiftClass()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        titleName = "SSRuntimeVC"
        
    }
    
    @IBAction func ivarBtnClick(_ sender: UIButton) {
        ivarList()
    }
    
    @IBAction func propertyBtnClick(_ sender: UIButton) {
        propertyList()
    }
    
    @IBAction func methodBtnClick(_ sender: Any) {
        methodList()
    }
    
    @IBAction func protocolBtnClick(_ sender: Any) {
        protocolList()
    }
    
    @IBAction func methodSwizzlingBtnClick(_ sender: Any) {
        swiftClass.methodSwizzing()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiftClass.orgFunc()
       
    }
    
    
    //---------------------------------------------------
    private func ivarList() {
        // swift其实提供Int8、Int16、Int32、Int64以及其对应的unsigned无符号的几个类型。都是结构体。
        // 其表示长度，Int8表示一个字节，2的8次方，-128~127之间。
        var ivarCount: UInt32 = 0
        let ivars = class_copyIvarList(type(of: swiftClass), &ivarCount)
        for i in 0 ..< numericCast(ivarCount) {
            let ivar = ivars![i]
            let ivarName = ivar_getName(ivar)
            print(String(utf8String: ivarName!)!)
        }
        free(ivars)
    }
    
    private func propertyList() {
        var propertyCount: UInt32 = 0
        let propertys = class_copyPropertyList(type(of: swiftClass), &propertyCount)
        for i in 0 ..< numericCast(propertyCount) {
            let property = propertys![i]
            let propertyName = property_getName(property)
            print(String(utf8String: propertyName)!)
        }
        free(propertys)
    }
    
    private func methodList() {
        var methodCount: UInt32 = 0
        let methods = class_copyMethodList(type(of: swiftClass), &methodCount)
        for i in 0 ..< numericCast(methodCount) {
            let method = methods![i]
            let methodName = method_getName(method)
            let methodTypeCoding = method_getTypeEncoding(method)
            print(methodName, methodTypeCoding ?? "null")
        }
        free(methods)
    }
    
    private func protocolList() {
        var protocolCount: UInt32 = 0
        let protocols = class_copyProtocolList(type(of: swiftClass), &protocolCount)
        for i in 0 ..< numericCast(protocolCount) {
            let pro = protocols![i]
            let proName = protocol_getName(pro)
            print(proName)
        }
    }
    
    
}

class SwiftClass {
    @objc var name: String = "swift"
    @objc dynamic var age: Int = 12

    private func swiftClassFunc() {
        
    }
}


/*
 分类增加属性
*/
extension SwiftClass {
    
    private struct AssociatedKey {
        static var propertyName = "propertyName"
    }
    
    var runtimeProperty: String? {
        
        set {
            objc_setAssociatedObject(self, &AssociatedKey.propertyName, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.propertyName) as? String
        }
    }
    
}



/*
 method swizzling
*/

extension SwiftClass {
    
    func methodSwizzing() {
        let orgSelector = #selector(orgFunc)
        let swzSelector = #selector(swizzingFunc)
        
        let orgMethod = class_getInstanceMethod(type(of: self), orgSelector)!
        let swzMethod = class_getInstanceMethod(type(of: self), swzSelector)!
        
        // 防止org方式是从父类继承过来的。
        let didAddidMehod = class_addMethod(type(of: self),
                                            orgSelector,
                                            method_getImplementation(swzMethod),
                                            method_getTypeEncoding(swzMethod))
        if didAddidMehod {
            class_replaceMethod(type(of: self),
                                swzSelector,
                                method_getImplementation(orgMethod),
                                method_getTypeEncoding(orgMethod))
        }else {
            method_exchangeImplementations(orgMethod, swzMethod)
        }
        
    }
    
    
    @objc func orgFunc() {
        print("orgFunc")
    }
    
    @objc  func swizzingFunc() {
        print("swizzingFunc")
    }
}

