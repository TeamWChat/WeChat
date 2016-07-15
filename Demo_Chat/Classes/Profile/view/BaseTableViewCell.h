//
//  BaseTableViewCell.h
//  Demo_Chat
//
//  Created by 李世民 on 16/7/13.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewCell : UITableViewCell
@property (nonatomic,weak) UILabel *contentLabel;
@property (weak, nonatomic)  UIImageView *rightImageView;
@property (nonatomic,copy) NSString *type;

-(void)contentLabelAddConstraint:(NSString *)str fontSize:(CGFloat)font width:(CGFloat)width height:(CGFloat)height;
-(void)rightImageViewAddConstraint:(NSString *)url;

+(instancetype)baseCellWithTableView:(UITableView *)tableView;

-(instancetype)initWithAccess:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier isAccess:(UITableViewCellAccessoryType)type;
@end
