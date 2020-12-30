//
//  SSSingleton.m
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/5/28.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

#import "SSSingleton.h"
#import "SSXiuShiFu.h"
#import <CoreGraphics/CoreGraphics.h>

@implementation SSSingleton


+ (instancetype)shareInstance {
    static SSSingleton *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[super allocWithZone:NULL] init];
    });
    return instance;
}

// 防止alloc、new创建造成新对象。
+(instancetype)allocWithZone:(struct _NSZone *)zone {
    
    return [self shareInstance];
}

-(void)test {

    
    
}

@end
