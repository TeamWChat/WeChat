//
//  WCInputView.m
//  Demo_Chat
//
//  Created by admin on 16/7/11.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "WCInputView.h"

@implementation WCInputView

+ (instancetype)inputView {
    return [[[NSBundle mainBundle] loadNibNamed:@"WCInputView" owner:nil options:nil] firstObject];
}

//- (void)awakeFromNib {
//    self.frame = CGRectMake(0, 0, kScreenWidth, 49);
//}

@end
