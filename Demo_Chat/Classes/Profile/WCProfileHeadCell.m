//
//  WCProfileHeadCell.m
//  Demo_Chat
//
//  Created by 李世民 on 16/7/12.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "WCProfileHeadCell.h"

#define avator @"http://ww3.sinaimg.cn/large/610dc034gw1f5pu0w0r56j20m80rsjuy.jpg"

@implementation WCProfileHeadCell

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.avatarImageView.layer.cornerRadius = 5.f;
    self.avatarImageView.clipsToBounds = YES;
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:avator]];
    self.userNameLabel.text = @"zuosdaf";
    self.accountLabel.text = @"15234562";
}

+(instancetype)weHeadCellWithTabelView:(UITableView *)tableView
{
    static NSString *identifier = @"HeadCell";
    WCProfileHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell==nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"WCProfileHeadCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
