//
//  WCOutputToolManager.h
//  Demo_Chat
//
//  Created by admin on 16/7/13.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WCInputView.h"
@class WCOutputToolManager;

@protocol WCOutputToolManagerDelegate <NSObject>

- (void)toolManager:(WCOutputToolManager *)toolManager willChangeFrameWithValue:(CGFloat)value duration:(CGFloat)duration;

@end

@interface WCOutputToolManager : UIViewController

@property (nonatomic, weak) id<WCOutputToolManagerDelegate> delegate;

+ (instancetype)showInSupperController:(UIViewController *)superViewController;

/**工具条收拢*/
- (void)popDown;

@end

