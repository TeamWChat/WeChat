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
+(CGSize)getLabelSize:(NSString *)str fontSize:(CGFloat)font
{
  return  [str boundingRectWithSize:CGSizeMake(280, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    
}


@end
