//
//  WCEmotionBag.h
//  Demo_Chat
//
//  Created by admin on 16/8/21.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WCEmotion;

@interface WCEmotionBag : NSObject

@property (nonatomic, readonly, copy) NSString *title;

@property (nonatomic, readonly) NSArray<WCEmotion*> *emotions;

- (instancetype)initWithTitle:(NSString *)title emotions:(NSArray<WCEmotion*> *)emotions;

@end
