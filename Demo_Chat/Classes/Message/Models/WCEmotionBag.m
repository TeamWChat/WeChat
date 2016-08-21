//
//  WCEmotionBag.m
//  Demo_Chat
//
//  Created by admin on 16/8/21.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "WCEmotionBag.h"

@implementation WCEmotionBag

- (instancetype)initWithTitle:(NSString *)title emotions:(NSArray<WCEmotion *> *)emotions {
    self = [super init];
    if (self) {
        _title = title;
        _emotions = emotions;
    }
    return self;
}

@end
