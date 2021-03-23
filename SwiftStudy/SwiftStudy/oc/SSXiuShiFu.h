//
//  SSXiuShiFu.h
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/5/28.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSXiuShiFu : NSObject {
    int _age;
}

@property(atomic, assign) NSString *name;

// NS_UNAVAILABLE 表示不能使用该方法。
-(instancetype)init NS_UNAVAILABLE;
-(instancetype)new NS_UNAVAILABLE;

-(instancetype)initWithName:(NSString *)name NS_DESIGNATED_INITIALIZER; 
@end

NS_ASSUME_NONNULL_END
