//
//  WCEmotion.m
//  Demo_Chat
//
//  Created by admin on 16/7/17.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "WCEmotion.h"
#import "NSString+Emojize.h"

@implementation WCEmotion

+ (NSArray *)emojis {
    NSDictionary *emojiAliases = [NSString emojiAliases];
    
    NSMutableArray *emojis = [NSMutableArray array];
    
    for (NSString *key in emojiAliases.allKeys) {
        WCEmotion *emotion = [[WCEmotion alloc] init];
        emotion.chs = key;
        emotion.code = [[emojiAliases objectForKey:key] emojizedString];
        [emojis addObject:emotion];
    }
    
    return emojis;
}


@end
