//
//  OCClass.h
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2019/12/20.
//  Copyright © 2019 Zhu ChaoJun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OCClass : NSObject

@property(atomic, strong) NSString *age;

-(void)origiClassMethod;



+(instancetype)shareInstance;

+(__kindof OCClass *)kindofInstance;

@end


NS_ASSUME_NONNULL_END
