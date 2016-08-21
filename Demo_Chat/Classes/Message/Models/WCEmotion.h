//
//  WCEmotion.h
//  Demo_Chat
//
//  Created by admin on 16/7/17.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCEmotion : NSObject

/**表情中文[格式]*/
@property (nonatomic, copy) NSString *chs;

/**表情code*/
@property (nonatomic, copy) NSString *code;

/**表情图片*/
@property (nonatomic, strong) NSString *image;

/**Emoji表情*/
@property (nonatomic, copy) NSString *emoji;

- (BOOL)isEmoji;

/**所有emoji表情*/
+ (NSArray *)emojis;

+ (NSArray *)emotions;

@end
