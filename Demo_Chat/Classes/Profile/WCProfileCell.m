//
//  WCProfileCell.m
//  Demo_Chat
//
//  Created by 李世民 on 16/7/12.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "WCProfileCell.h"

@implementation WCProfileCell

+(instancetype)weCellWithTabelView:(UITableView *)tableView
{
    static NSString *identifier = @"Cell";
    WCProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell==nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"WCProfileCell" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
//    self.whatLabel.text = @"afds";
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
