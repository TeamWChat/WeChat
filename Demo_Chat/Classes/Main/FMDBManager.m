//
//  FMDBManager.m
//  Demo_Chat
//
//  Created by 李世民 on 16/7/14.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "FMDBManager.h"


@interface FMDBManager ()

@property (nonatomic,strong) FMDatabase *db;

@end

@implementation FMDBManager


+(instancetype)sharedInstance
{
    static FMDBManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self new];
    });
    return sharedInstance;
}


@end
