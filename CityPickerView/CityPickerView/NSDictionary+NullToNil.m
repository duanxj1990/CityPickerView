//
//  NSDictionary+NullToNil.m
//  hxxdj
//
//  Created by aisino on 16/4/6.
//  Copyright © 2016年 aisino. All rights reserved.
//

#import "NSDictionary+NullToNil.h"

@implementation NSDictionary (NullToNil)

- (id)noNullobjectForKey:(NSString *)key{
    //判断数据字符串是否为null,避免崩溃
    id dataStr = [self objectForKey:key];
    if ([dataStr isKindOfClass:[NSNull class]]) {
        return nil;
    } else {
        return dataStr;
    }
}

@end
