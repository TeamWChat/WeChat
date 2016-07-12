//
//  WCProfileHeadCell.m
//  Demo_Chat
//
//  Created by 李世民 on 16/7/12.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "WCProfileHeadCell.h"



@implementation WCProfileHeadCell

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:@""]];
    self.userNameLabel.text = @"zuosdaf";
    self.accountLabel.text = @"15234562";
}

+(instancetype)weHeadCellWithTabelView:(UITableView *)tableView
{
    static NSString *identifier = @"HeadCell";
    WCProfileHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell==nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"WCProfileHeadCell" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
