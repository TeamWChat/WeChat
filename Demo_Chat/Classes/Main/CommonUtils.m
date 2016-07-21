//
//  CommonUtils.m
//  Demo_Chat
//
//  Created by 李世民 on 16/7/13.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "CommonUtils.h"

@implementation CommonUtils

//动态获取字符长度
+(CGSize)getLabelSize:(NSString *)str fontSize:(CGFloat)font width:(CGFloat)width height:(CGFloat)height
{
  return  [str boundingRectWithSize:CGSizeMake(width, height) options:NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    
}
//根据不同的需求创建item
//系统item
+(UIBarButtonItem *)navBarButtonItemWithimage:(UIImage *)image target:(UIViewController *)target action:(SEL)action
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:target action:action];
    return item;
}

//自定义item
+(UIBarButtonItem *)navBarButtonItemWithView:(UIImage *)image text:(NSString *)text font:(CGFloat)font viewWith:(CGFloat)with viewHeight:(CGFloat)height target:(UIViewController *)target action:(SEL)action
{
    UIButton *imageBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, with, height)];
    [imageBtn setBackgroundImage:image forState:UIControlStateNormal];
    [imageBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [imageBtn setTitle:text forState:UIControlStateNormal];
    imageBtn.titleLabel.font = [UIFont systemFontOfSize:font];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:imageBtn];

    return item;
}


//将图片存入数据库
+(void)writeImageToDB:(UIImage *)image
{
    //把图片转换
    NSData *data = UIImageJPEGRepresentation(image, 1);
    NSData *oldData = [self getImageFromDB];
    
    
    //1.获得数据库文件的路径
    NSString *doc =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)  lastObject];
    
    NSString *fileName = [doc stringByAppendingPathComponent:@"pic.sqlite"];
    
    //2.获得数据库
    FMDatabase *db = [FMDatabase databaseWithPath:fileName];
    if (![data isEqual:oldData]) {//如果图片不相等
        
        if ([db open]) {
            BOOL ret = [db executeUpdate:@"create table if not exists t_pic (photo blob)"];
            if (ret) {
                NSLog(@"添加成功");
            }
            else
            {
                NSLog(@"添加失败");
            }
            [db close];
        }
        
        
        
        if ([db open]) {
            BOOL ret = [db executeUpdate:@"insert into t_pic (photo) values (?)",data];
            if (ret) {
                NSLog(@"图片添加成功");
            }
            else
            {
                NSLog(@"图片添加失败");
            }
            [db close];
        }
    }
}



//将图片写入数据库
+(NSData *)getImageFromDB
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName = [path stringByAppendingPathComponent:@"pic.sqlite"];
    NSData *imageData;
    FMDatabase *db = [FMDatabase databaseWithPath:fileName];
    if ([db open]) {
        NSString *sqlStr = [NSString stringWithFormat:@"SELECT * FROM t_pic"];
        FMResultSet *rs = [db executeQuery:sqlStr];
        while ([rs next]) {
            imageData = [rs dataForColumn:@"photo"];
        }
        [db close];
    }
    return imageData;
}


/**将图片写入文件*/
+(void)writeImageToFile:(UIImage *)image imageName:(NSString *)imageName;
{
    NSData *data;
    if (UIImagePNGRepresentation(image) ==nil)
    {
        data = UIImageJPEGRepresentation(image,1.0);
    }
    else
    {
        data = UIImagePNGRepresentation(image);
    }

    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *fileName = [path stringByAppendingString:imageName];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    [manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    [manager createFileAtPath:fileName contents:data attributes:nil];
}

/**从文件获得图片*/
+(UIImage *)getImageFromFileWithImageName:(NSString *)imageName
{
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *fileName = [path stringByAppendingString:imageName];
    NSFileManager *manager = [NSFileManager defaultManager];
    NSData *data = [manager contentsAtPath:fileName];
    UIImage *image = [UIImage imageWithData:data];
    return image;
}

@end
