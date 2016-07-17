//
//  WCEmotion.h
//  Demo_Chat
//
//  Created by admin on 16/7/17.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCEmotion : NSObject

@property (nonatomic, copy) NSString *chs;

@property (nonatomic, copy) NSString *code;

@property (nonatomic, strong) NSString *image;

/**所有emoji表情*/
+ (NSArray *)emojis;

@end
