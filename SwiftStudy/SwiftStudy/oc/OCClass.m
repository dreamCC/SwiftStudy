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
#import "OCChild.h"



// oc中的协议也是可以定义，属性和方法的。
@protocol CustomOCProtocol <NSObject>

@property(nonatomic, strong) NSString *name;

@end


@interface OCClass ()


@property(nonatomic, strong) NSString *dynamic;

@property(nonatomic, strong) NSString *  synthesize;
@end

@implementation OCClass

// MARK:
@synthesize synthesize = _synSynthesize;

@dynamic dynamic;

+(instancetype)shareInstance {
    static dispatch_once_t  onceToken;
    static OCClass *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[super allocWithZone:NULL] init];
    
    
    });
    return instance;
}


+(instancetype)allocWithZone:(struct _NSZone *)zone {
    return [self shareInstance];
}

// TODO: 这是todo
// FIXME: 这是fixme
// MARK: 这是mark
// !!!: 这是叹号
// ???: 这是问号
-(instancetype)init {
    self = [super init];
    if (self) {
    
    
    }
    
    return self;
}








-(BOOL)numberNoto:(NSString *)name age:(NSString *)age {

   
    return YES;
}

-(void)origiClassMethod {
    
    
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"--------%@", key);
}



@end



