//
//  WCNavigationController.m
//  Demo_Chat
//
//  Created by admin on 16/7/11.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "WCNavigationController.h"

@interface WCNavigationController ()

@end

@implementation WCNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0 green:(189/255.f) blue:0 alpha:1]} forState:UIControlStateSelected];
    
    self.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navigationBar.tintColor = [UIColor whiteColor];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
