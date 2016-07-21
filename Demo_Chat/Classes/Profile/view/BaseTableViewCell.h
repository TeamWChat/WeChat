//
//  BaseTableViewCell.h
//  Demo_Chat
//
//  Created by 李世民 on 16/7/13.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewCell : UITableViewCell


@property (nonatomic,weak) UILabel *leftLabel;
@property (nonatomic,weak) UILabel *contentLabel;
@property (weak, nonatomic)  UIImageView *rightImageView;
@property (nonatomic,copy) NSString *type;

-(void)contentLabelAddConstraint:(NSString *)str fontSize:(CGFloat)font MaxWidth:(CGFloat)MaxWidth MaxHeight:(CGFloat)MaxHeight;
-(void)rightImageViewAddConstraint:(NSString *)url;

+(instancetype)baseCellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style access:(UITableViewCellAccessoryType)access;

-(instancetype)initWithAccess:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier isAccess:(UITableViewCellAccessoryType)type;
@end
