//
//  WCProfilePersonInfo.m
//  Demo_Chat
//
//  Created by 李世民 on 16/7/15.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "WCProfilePersonInfo.h"

@implementation WCProfilePersonInfo

+(instancetype)shareInstance
{
    static WCProfilePersonInfo *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] init];
    });
    return shareInstance;
}


@end
