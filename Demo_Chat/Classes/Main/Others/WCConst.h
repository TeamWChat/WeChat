//
//  WCConst.h
//  Demo_Chat
//
//  Created by admin on 16/8/21.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

//点击表情按钮通知
UIKIT_EXTERN NSString *const kWCEmotionButtonDidTouchUpInsideNotification;
//点击删除按钮通知(表情界面)
UIKIT_EXTERN NSString *const kWCEmotionDeleteButtonDidTouchUpInsideNotification;
//表情UserInfo Key
UIKIT_EXTERN NSString *const kWCEmotionModelKey;
//发送消息通知
UIKIT_EXTERN NSString *const kWCInputViewDidSendMessageNotification;
//发送消息UserInfo Key
UIKIT_EXTERN NSString *const kWCInputViewMessageKey;
//开始语音聊天通知
UIKIT_EXTERN NSString *const kWCInputViewDidStartTalkNotification;
//暂停语音聊天通知
UIKIT_EXTERN NSString *const kWCInputViewDidPauseTalkNotification;
//完成语音聊天通知
UIKIT_EXTERN NSString *const kWCInputViewDidFinishTalkNotification;
//取消语音聊天通知
UIKIT_EXTERN NSString *const kWCInputViewDidCancelTalkNotification;