//
//  InfoCell.h
//  Demo_Chat
//
//  Created by 李世民 on 16/7/21.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoCell : UITableViewCell

@property (nonatomic,strong) UILabel *leftLabel;
@property (nonatomic,strong) UILabel *rightLabel;
@property (nonatomic,strong) UIImageView *avatarImage;

@property (nonatomic,copy) NSString *titals;

//添加右边图片
-(void)rightImageViewAddConstraint:(NSString *)url;
+(instancetype)infoCellWithTabelView:(UITableView *)tableView;
@end
