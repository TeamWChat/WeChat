//
//  CommonUtils.h
//  Demo_Chat
//
//  Created by 李世民 on 16/7/13.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonUtils : NSObject

+(CGSize)getLabelSize:(NSString *)str fontSize:(CGFloat )font;

+(void)navRightBarButtonItemWithimage:(UIImage *)image target:(id)target action:(SEL)action;
+(void)navRightBarButtonItemWithView:(UIImage *)image text:(NSString *)text font:(CGFloat)font viewWith:(CGFloat)with viewHeight:(CGFloat)height target:(UIViewController *)target action:(SEL)action;
//将图片存入数据库
+(void)writeImageToDB:(UIImage *)image;
+(NSData *)getImageFromDB;
@end
