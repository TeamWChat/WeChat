//
//  WCEmotion.m
//  Demo_Chat
//
//  Created by admin on 16/7/17.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "WCEmotion.h"
#import "NSString+Emojize.h"

#define EMOJI_CODE_TO_SYMBOL(x) ((((0x808080F0 | (x & 0x3F000) >> 4) | (x & 0xFC0) << 10) | (x & 0x1C0000) << 18) | (x & 0x3F) << 24);

@implementation WCEmotion

+ (NSArray *)emojis {
    NSDictionary *emojiAliases = [NSString emojiAliases];
    
    NSArray *allKeysNoSort = emojiAliases.allKeys;
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES];
    NSArray *allKeys = [allKeysNoSort sortedArrayUsingDescriptors:@[descriptor]];
    NSMutableArray *emojis = [NSMutableArray array];
    for (NSString *emoji in allKeys) {
        WCEmotion *emotion = [[WCEmotion alloc] init];
        emotion.emoji = emoji;
        [emojis addObject:emotion];
    }
    
    return emojis;
}

- (BOOL)isEmoji {
    return (self.emoji != nil);
}

+ (NSArray *)emotions {
    NSString *emotionFilePath = [[NSBundle mainBundle] pathForResource:@"emotion" ofType:@"plist"];
    NSMutableArray *emotions = [WCEmotion mj_objectArrayWithFile:emotionFilePath];
    return emotions;
}


@end
