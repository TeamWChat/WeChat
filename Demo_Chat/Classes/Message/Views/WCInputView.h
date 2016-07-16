//
//  WCInputView.h
//  Demo_Chat
//
//  Created by admin on 16/7/11.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WCInputView;
@protocol WCInputViewDelegate;


@interface WCInputView : UIView

@property (nonatomic, assign) BOOL keyboardStatus;

@property (nonatomic, weak) id<WCInputViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *textField;

+ (instancetype)inputView;

- (void)resetButtonState;

@end

@protocol WCInputViewDelegate <NSObject>

- (void)inputView:(WCInputView *)inputView emotionButtonDidTouch:(UIButton *)emotionButton;

- (void)inputView:(WCInputView *)inputView voiceButtonDidTouch:(UIButton *)voiceButton;

- (void)inputView:(WCInputView *)inputView keyboardButtonDidTouch:(UIButton *)keyboardButton;

- (void)inputView:(WCInputView *)inputView typeSelectButtonDidTouch:(UIButton *)typeSelectButton;

@end

UIKIT_EXTERN NSString *const kWCInputViewDidSendMessageNotification;
UIKIT_EXTERN NSString *const kWCInputViewMessageKey;

UIKIT_EXTERN NSString *const kWCInputViewDidStartTalkNotification;
UIKIT_EXTERN NSString *const kWCInputViewDidPauseTalkNotification;
UIKIT_EXTERN NSString *const kWCInputViewDidFinishTalkNotification;
UIKIT_EXTERN NSString *const kWCInputViewDidCancelTalkNotification;
