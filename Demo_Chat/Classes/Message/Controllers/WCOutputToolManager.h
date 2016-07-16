//
//  WCOutputToolManager.h
//  Demo_Chat
//
//  Created by admin on 16/7/13.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WCInputView.h"

@interface WCOutputToolManager : UIViewController

+ (instancetype)showInSupperController:(UIViewController *)superViewController;

/**工具条收拢*/
- (void)popDown;

@end

