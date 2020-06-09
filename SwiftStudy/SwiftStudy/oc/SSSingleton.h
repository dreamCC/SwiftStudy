//
//  SSSingleton.h
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/5/28.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSSingleton : NSObject


+(instancetype)shareInstance;

@end

NS_ASSUME_NONNULL_END
