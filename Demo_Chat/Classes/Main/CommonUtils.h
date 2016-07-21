//
//  CommonUtils.h
//  Demo_Chat
//
//  Created by 李世民 on 16/7/13.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonUtils : NSObject

+(CGSize)getLabelSize:(NSString *)str fontSize:(CGFloat)font width:(CGFloat)width height:(CGFloat)height;

/**根据图片创建系统右Item*/
+(UIBarButtonItem *)navBarButtonItemWithimage:(UIImage *)image target:(id)target action:(SEL)action;
/**根据图片创建自定义右Item*/
+(UIBarButtonItem *)navBarButtonItemWithView:(UIImage *)image text:(NSString *)text font:(CGFloat)font viewWith:(CGFloat)with viewHeight:(CGFloat)height target:(UIViewController *)target action:(SEL)action;
/**将图片存入数据库不建议使用*/
+(void)writeImageToDB:(UIImage *)image;
/**从数据库获得图片不建议使用*/
+(NSData *)getImageFromDB;
/**将图片写入文件*/
+(void)writeImageToFile:(UIImage *)image imageName:(NSString *)imageName;
/**从文件获取图片*/
+(UIImage *)getImageFromFileWithImageName:(NSString *)imageName;

@end
