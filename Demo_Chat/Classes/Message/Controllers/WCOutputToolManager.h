//
//  WCOutputToolManager.h
//  Demo_Chat
//
//  Created by admin on 16/7/13.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WCOutputToolManager : UIViewController

@property (nonatomic, assign) BOOL canHideKeyboard;

+ (instancetype)showInSupperController:(UIViewController *)superViewController;

- (void)endTyping;

@end
