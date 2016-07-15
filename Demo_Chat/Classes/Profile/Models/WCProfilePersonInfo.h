//
//  WCProfilePersonInfo.h
//  Demo_Chat
//
//  Created by 李世民 on 16/7/15.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCProfilePersonInfo : NSObject

@property (nonatomic,copy) NSString *userName;
@property (nonatomic,copy) UIImage *image;
@property (nonatomic,copy) NSString *userId;

@property (nonatomic,copy) NSString *adress;
@property (nonatomic,copy) NSString *sex;
@property (nonatomic,copy) NSString *location;

@property (nonatomic,copy) NSString *whatHeWhatToSay;

+(instancetype)shareInstance;
@end
