//
//  OCClass.m
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2019/12/20.
//  Copyright © 2019 Zhu ChaoJun. All rights reserved.
//

#import "OCClass.h"
#import "SwiftStudy-Swift.h"
#import <objc/runtime.h>



// oc中的协议也是可以定义，属性和方法的。
@protocol CustomOCProtocol <NSObject>

@property(nonatomic, strong) NSString *name;


@end


@interface OCClass ()

@end

@implementation OCClass




-(instancetype)init {
    self = [super init];
    if (self) {
       
    

      
    }
    return self;
}



-(void)origiClassMethod {
    
    
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"--------%@", key);
}



@end



