//
//  WCEmotionItemCell.m
//  Demo_Chat
//
//  Created by admin on 16/7/17.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "WCEmotionItemCell.h"
#import "WCEmotion.h"

#define kRandomColorOffset (arc4random()%255/255.f)

@interface WCEmotionItemCell ()

@property (nonatomic, weak) UIButton *emotionButton;

@end


@implementation WCEmotionItemCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithRed:kRandomColorOffset green:kRandomColorOffset blue:kRandomColorOffset alpha:1];
        
        [self setupEmotionButton];
    }
    return self;
}

- (void)setupEmotionButton {
    UIButton *emotionButton = [[UIButton alloc] init];
    [self.contentView addSubview:emotionButton];
    self.emotionButton = emotionButton;
    
    //约束
    [emotionButton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    
    //添加事件
    [emotionButton addTarget:self action:@selector(respondsToEmotionButtonEnter:) forControlEvents:UIControlEventTouchDragEnter];
    [emotionButton addTarget:self action:@selector(respondsToEmotionButtonExit:) forControlEvents:UIControlEventTouchDragExit];
    [emotionButton addTarget:self action:@selector(respondsToEmotionButtonTouchDown:) forControlEvents:UIControlEventTouchDown];
    [emotionButton addTarget:self action:@selector(respondsToEmotionButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setEmotion:(WCEmotion *)emotion {
    _emotion = emotion;
    
    [self.emotionButton setTitle:emotion.code forState:UIControlStateNormal];
}

#pragma mark - action

- (void)respondsToEmotionButtonEnter:(UIButton *)sender {
    //显示popupView
}

- (void)respondsToEmotionButtonExit:(UIButton *)sender {
    //移除popupView
}

- (void)respondsToEmotionButtonTouchDown:(UIButton *)sender {
    
    //若0.5秒后还是inTouchInside状态,则显示popupView
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (sender.isTouchInside) {//显示popupView
            
        }
    });
}

- (void)respondsToEmotionButtonTouchUpInside:(UIButton *)sender {
    //选择表情
}

#pragma mark - popupView



@end
