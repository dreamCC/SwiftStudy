//
//  TestKvo.m
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2021/4/15.
//  Copyright © 2021 Zhu ChaoJun. All rights reserved.
//

#import "TestKvo.h"
#import "SwiftStudy-Swift.h"
@implementation TestKvo {
    KvoClass *_kvoCls;
}


-(void)doTest {
    
    _kvoCls = [[KvoClass alloc] init];
    [_kvoCls addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    
    _kvoCls.name = @"new";
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"监听到属性变化-%@", keyPath);
}


@end
