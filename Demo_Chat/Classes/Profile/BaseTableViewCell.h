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

-(void)contentLabelAddConstraint:(NSString *)str fontSize:(CGFloat)font;
-(void)rightImageViewAddConstraint:(NSString *)url;

+(instancetype)baseCellWithTableView:(UITableView *)tableView;
@end
